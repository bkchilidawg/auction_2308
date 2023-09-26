require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

  end

  describe '#initialize' do
    it 'exists' do
      expect(@auction).to be_a Auction 
      expect(@auction.items).to be_a Array
    end
  end

  describe '#add_item' do
    it 'will add an item to the items list' do

      @auction.add_item(@item1)
      @auction.add_item(@item2)

     expect(@auction.items.length).to eq 2
    end
  end

  describe '#item_names' do
    it 'return the item names in an array' do

      @auction.add_item(@item1)
      @auction.add_item(@item2)

      expect(@auction.item_names).to eq ['Chalkware Piggy Bank', 'Bamboo Picture Frame']
    end
  end

  describe '#unpopular_items' do
    it 'will return an array of items that are not popular' do

      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
     
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)

      expect(@auction.unpopular_items.length).to eq 3 
    end
  end

  describe '#potential_revenue' do
    it 'will return the current potential revenue' do

      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
     
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.unpopular_items.length).to eq 2
      expect(@auction.potential_revenue).to eq 87  
    end
  end
  describe '#bidders' do
    it 'will return an array of bidder names' do

      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.bidders.length).to eq 3  
    end
  end

  describe '#bidder_info' do
    it " will return bidders info" do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.bidder_info).to eq(
      @attendee1 => { budget: 50, items: [@item1] },
      @attendee2 => { budget: 75, items: [@item3] },
      @attendee3 => { budget: 100, items: [@item4] }
      )
    end
  end
end 