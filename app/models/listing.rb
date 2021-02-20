class Listing < ApplicationRecord
  belongs_to :user
  validates :zip_code, :produce_name, :produce_type, :quantity, :unit, :date_harvested, presence: true
end
