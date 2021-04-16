class Listing < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy 
  validates :zip_code, :produce_name, :produce_type, :quantity, :unit, :date_harvested, presence: true

  class << self 
    # removed time constraint filter to more easily demo
    # def three_days_ago 
    #   DateTime.now - 3.days
    # end

    def get_listings(zip_codes = nil)
      if zip_codes
        Listing.where('zip_code IN (?)', zip_codes)
               .order(:produce_name) 
               .group_by(&:produce_name)
      else 
        Listing.order(:produce_name)
               .group_by(&:produce_name)
      end 
    end
  end
  
end
