# frozen_string_literal: true

ActiveAdmin.register Book do
  decorate_with BookDecorator

  permit_params :title, :cover, :price, :description, :publication_year, :height, :width, :depth, :material, :quantity,
                :category_id, author_ids: [], book_photos_attributes: {}
  config.filters = false

  includes :category, :authors

  index do
    selectable_column
    column :cover do |book|
      image_tag book.show_cover(:small)
    end
    column :categories do |book|
      book.category.name
    end
    column :categories do |book|
      book.category.name
    end
    column :title
    column :authors, &:authors_as_string
    column :description, &:medium_description
    column :price, &:price
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :cover, as: :file
      f.has_many :book_photos do |p|
        p.input :image, as: :file
      end
      f.input :description
      f.input :price
      f.input :publication_year
      f.input :height
      f.input :width
      f.input :depth
      f.input :material
      f.input :quantity
      f.input :category, as: :radio, collection: Category.all.map { |category| [category.name, category.id] }
      f.input :authors, as: :check_boxes, collection: Author.all.decorate.map { |author| [author.full_name, author.id] }
      f.actions
    end
  end

  show do
    panel 'Book Details' do
      attributes_table_for book do
        row :title
        row :price
        row :description
        row :publication_year
        row :height
        row :width
        row :depth
        row :material
        row :quantity
        row :category
        row :authors, &:authors_as_string
      end
    end
    active_admin_comments
  end
end
