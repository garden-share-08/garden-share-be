class ChangeColumnOnListings < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :quantity, :integer
  end
end
