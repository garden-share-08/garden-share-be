class ChangeDateHarvestedOnListings < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :date_harvested, :string
  end
end
