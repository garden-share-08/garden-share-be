require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :listings }
  it { should have_many :offers }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
end
