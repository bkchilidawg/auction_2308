class Item
  attr_reader :name, :bids, :bidding_closed

  def initialize(name)
    @name = name
    @bids = {} 
    @bidding_closed = false
  end

  def add_bid(attendee, bid)
    if @bidding_closed == false
    @bids[attendee] = bid
    elsif @bidding_closed == true
      "I'm sorry, bidding is closed for this item"
    end
  end

  def current_high_bid
    @bids.values.max || 0
  end

  def close_bidding
    @bidding_closed = true
  end
end