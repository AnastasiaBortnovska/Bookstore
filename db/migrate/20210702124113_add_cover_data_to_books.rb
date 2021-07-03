class AddCoverDataToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :cover_data, :text
    add_column :books, :images_data, :text
  end
end
