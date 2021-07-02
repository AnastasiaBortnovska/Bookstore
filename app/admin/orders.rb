ActiveAdmin.register Order do
  decorate_with OrderDecorator

  actions :index, :edit, :update

  permit_params :status

  config.filters = false

  scope(I18n.t('admin.orders.in_progres')) { |scope| scope.where.not(status: 3 || 4)}
  scope :delivered
  scope :canceled

  index do
    selectable_column
    column :number
    column I18n.t('admin.orders.date_of_creation') do |order|
      order.creation_date
    end
    column I18n.t('admin.orders.status') do |order|
      order.status
    end
    actions defaults: false do |order|
      link_to I18n.t('admin.orders.change_state'), edit_admin_order_path(order)
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :status, as: :select, collection: order.decorate.select_status.map { |status|
        [status.capitalize.tr('_', ' '), status]
      }
      f.actions
    end
  end
end
