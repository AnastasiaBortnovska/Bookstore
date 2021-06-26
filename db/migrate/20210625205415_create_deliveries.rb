class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :name, null: false
      t.string :days, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
