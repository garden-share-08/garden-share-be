require 'rails_helper'

RSpec.describe 'LocationService' do 
 describe 'can request zip codes from our microservice' do
    it 'with zip code and radius' do 
      zip_codes = File.read('spec/fixtures/get_zip_codes.json')

      zip_code = "80017"
      radius = 5

      stub_request(:get, "https://garden-share-be.herokuapp.com/zipcodes/#{zip_code}/#{radius}")
        .to_return(status: 200, body: zip_codes, headers: {})
      
      expected_zip_codes = ["80015","80013","80014","80040","80041","80042","80044","80046","80047","80017","80247","80012","80011","80045"]

      result = LocationService.get_zip_codes(zip_code, radius)

      expect(result[:error_code]).to eq('')
      expect(result[:error_msg]).to eq('')
      expect(result[:zip_codes]).to eq(expected_zip_codes)
    end 

    it 'unless zipcode is inaccurate' do 
      radius = 10
      zip_code = "99999"

      error = {
        zip_codes: "",
        error_code: 404,
        error_msg: "Zip code \"#{zip_code}\" not found."
      }

      stub_request(:get, "https://garden-share-be.herokuapp.com/zipcodes/#{zip_code}/#{radius}")
        .to_return(status: 404, body: error.to_json, headers: {})
      
      result = LocationService.get_zip_codes(zip_code, radius)

      expect(result[:zip_codes]).to eq('')
      expect(result[:error_code]).to eq(404)
      expect(result[:error_msg]).to eq("Zip code \"#{zip_code}\" not found.")
    end
  end
end
