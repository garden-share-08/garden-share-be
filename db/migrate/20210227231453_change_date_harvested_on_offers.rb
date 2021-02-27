class ChangeDateHarvestedOnOffers < ActiveRecord::Migration[5.2]
  def change
    change_column :offers, :date_harvested, :string
  end
end
