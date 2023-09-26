require 'date'
class Auction
  attr_reader :items, :date
  def initialize(date = Date.today.strftime("%d/%m/%Y") )
    @items = []
    @date = date 
  end

  def add_item(item)
    @items << item
  end

  def item_names
    item_names = []
    @items.each do |item|
      item_names << item.name
    end

    item_names
  end

  def unpopular_items
    @items.select { |item| item.bids.empty? }
  end

  def potential_revenue
    @items.sum { |item| item.current_high_bid }
  end

  def bidders 
    bidder_names = []
    @items.each do |item|
      item.bids.keys.each do |bidder|
        bidder_names << bidder.name unless bidder_names.include?(bidder.name)
      end
    end

      bidder_names
  end

  def bidder_info
    bidder_info_hash = {}
    @items.each do |item|
      item.bids.each do |bidder, bid|
        bidder_info_hash[bidder] ||= { budget: bidder.budget, items: [] }
        bidder_info_hash[bidder][:items] << item
      end
    end

    bidder_info_hash
  end

  def close_auction
    item_purchasers = {}
    items_won = @items.sort_by { |item| item.current_high_bid }

    items_won.each do |item|
      highest_bidder = item.bids.keys.first
      
  
      until highest_bidder.nil? || highest_bidder.budget >= item.current_high_bid
        item.bids.delete(highest_bidder)
        highest_bidder = item.bids.keys.first
      end

      if highest_bidder && highest_bidder.budget >= item.current_high_bid
        item_purchasers[item] = highest_bidder
        highest_bidder.budget -= item.current_high_bid
      else
        item_purchasers[item] = 'Not Sold'
      end
    end

    item_purchasers
  end

end