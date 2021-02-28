class ChangeStatusOnListingsDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :status, :string, default: "pending"
  end
end
