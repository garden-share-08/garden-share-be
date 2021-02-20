class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates :produce_name, :produce_type, :quantity, :unit, :date_harvested, presence: true
end
