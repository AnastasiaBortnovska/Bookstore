class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.string :name, null: false
      t.string :expire_date
      t.integer :cvv
      t.references :order, foreign_key: true, index: true

      t.timestamps
    end
  end
end
