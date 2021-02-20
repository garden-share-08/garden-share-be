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
end
