class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.string :produce_name
      t.string :produce_type
      t.string :description
      t.integer :quantity
      t.string :unit
      t.datetime :date_harvested
      t.string :status

      t.timestamps
    end
  end
end
