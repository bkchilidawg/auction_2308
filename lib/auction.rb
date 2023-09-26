class Auction
  attr_reader :items 
  def initialize
    @items = []
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


end