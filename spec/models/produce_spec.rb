require 'rails_helper'

RSpec.describe Produce, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :image }
end
