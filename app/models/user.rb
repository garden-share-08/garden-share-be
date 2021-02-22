class User < ApplicationRecord
  has_many :listings
  has_many :offers 
  validates :first_name, :last_name, :email, presence: true 
  validates_uniqueness_of :email 
end
