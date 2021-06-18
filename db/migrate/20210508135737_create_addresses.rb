class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :zip, null: false
      t.string :phone, null: false
      t.string :type, null: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
