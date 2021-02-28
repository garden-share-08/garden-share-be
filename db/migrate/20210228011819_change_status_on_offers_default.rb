class ChangeStatusOnOffersDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :offers, :status, :string, default: "pending"
  end
end
