class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :zip_code
      t.string :produce_name
      t.string :produce_type
      t.string :description
      t.numeric :quantity
      t.string :unit
      t.datetime :date_harvested
      t.string :status

      t.timestamps
    end
  end
end
