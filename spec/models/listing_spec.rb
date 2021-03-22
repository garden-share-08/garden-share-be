require 'rails_helper'

RSpec.describe Listing, type: :model do
  it { should validate_presence_of :zip_code }
  it { should validate_presence_of :produce_name }
  it { should validate_presence_of :produce_type }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :unit }
  it { should validate_presence_of :date_harvested }

  it { should belong_to :user }
  it { should have_many :offers }

  describe 'methods' do 
    describe 'get_filtered_listings' do 
      it 'returns listings no older than 72 hours' do 
        no_show = create(:listing, updated_at: DateTime.now - 4.days)
        show = create(:listing, updated_at: DateTime.now - 2.days)

        result = Listing.get_listings 

        expect(result["#{show.produce_name}"]).to include(show)
        expect(result["#{no_show.produce_name}"]).to eq(nil)
      end

      it 'return listings alphabetically' do 
        banana = create(:listing, produce_name: 'banana')
        apple = create(:listing, produce_name: 'apple')
        pepper = create(:listing, produce_name: 'pepper')
        date = create(:listing, produce_name: 'date')

        result = Listing.get_listings

        expect(result["#{apple.produce_name}"][0]).to eq(apple)
        expect(result["#{banana.produce_name}"][0]).to eq(banana)
        expect(result["#{date.produce_name}"][0]).to eq(date)
        expect(result["#{pepper.produce_name}"][0]).to eq(pepper)
      end

      it 'groups listings by produce name' do 
        banana = create(:listing, produce_name: 'banana')
        banana_2 = create(:listing, produce_name: 'banana')
        apple = create(:listing, produce_name: 'apple')
        apple_2 = create(:listing, produce_name: 'apple')
        pepper = create(:listing, produce_name: 'pepper')
        date = create(:listing, produce_name: 'date')

        result = Listing.get_listings

        result_keys = ['apple', 'banana', 'date', 'pepper']

        expect(result.class).to eq(Hash)
        expect(result.keys).to eq(result_keys)
        expect(result['apple'].count).to eq(2)
        expect(result['banana'].count).to eq(2)
        expect(result['date'].count).to eq(1)
        expect(result['pepper'].count).to eq(1)
      end

      it 'returns {} with no recent listings' do 
        no_show = create(:listing, updated_at: DateTime.now - 5.days)
        
        result = Listing.get_listings 
        expect(result).to eq({})
      end

      it 'filters listings by radius and zip code' do 
        zip_codes = JSON.parse(File.read('spec/fixtures/get_zip_codes.json'), symbolize_names: true)[:zip_codes]

        show_listing = create(:listing, zip_code: "80015", date_harvested: DateTime.now(), produce_name: 'Apples')
        no_show_listing = create(:listing, zip_code: "45505", date_harvested: DateTime.now(), produce_name: 'Grapes')

        result = Listing.get_listings(zip_codes)

        expect(result["#{show_listing.produce_name}"][0]).to eq(show_listing)
        expect(result["#{no_show_listing.produce_name}"]).to eq(nil)
      end
    end
  end
  
end
