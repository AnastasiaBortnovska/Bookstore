# frozen_string_literal: true

ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  config.filters = false

  index do
    selectable_column
    column :first_name
    column :last_name
    column :description
    actions
  end
end
