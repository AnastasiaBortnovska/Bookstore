class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.decimal :price, null: false, precision: 12, scale: 2
      t.text :description, null: false
      t.integer :publication_year, null: false
      t.float :height
      t.float :width
      t.float :depth
      t.string :material
      t.integer :quantity
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
