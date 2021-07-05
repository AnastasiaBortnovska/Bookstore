class AddCoverDataToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :cover_data, :text
  end
end
