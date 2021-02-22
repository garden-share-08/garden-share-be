class Produce < ApplicationRecord
  validates :name, :image, presence: true
end
