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

  describe '#date' do
    it 'returns the of the auction' do
      
      expect(@auction.date).to eq '26/09/2023'  
      
      @auction = Auction.new('01/01/2022')

      expect(@auction.date).to eq '01/01/2022'  

      @auction = Auction.new('27/09/2023')

      expect(@auction.date).to eq '27/09/2023'  
    end
  end

  describe '#close_auction' do
    it 'closes the auction and returns a hash of item purchasers' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      @item2.add_bid(@attendee2, 30)

      expect(@auction.close_auction).to eq({
        @item4 => @attendee3,
        @item2 => @attendee2,
        @item1 => @attendee1,
        @item3 => @attendee2,
        @item5 => 'Not Sold'
      })
    end

    it 'handles cases where bidders have insufficient budgets' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      @item2.add_bid(@attendee2, 30)
      
      @item5.add_bid(@attendee3, 5)

      expect(@auction.close_auction[@item4]).to eq(@attendee3)
      expect(@auction.close_auction[@item2]).to eq(@attendee1)
      expect(@auction.close_auction[@item1]).to eq(@attendee1)
      expect(@auction.close_auction[@item3]).to eq(@attendee2)
      expect(@auction.close_auction[@item5]).to eq(@attendee2) 
    end
  end
end 