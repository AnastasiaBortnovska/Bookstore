class AddressForm < Reform::Form
  property :user

  property :billing_address, prepopulator: :build_billing_address, populate_if_empty: BillingAddress do
    property :first_name
    property :last_name
    property :country
    property :city
    property :address
    property :phone
    property :zip

    extend ActiveModel::ModelValidations
    copy_validations_from Address
  end

  property :shipping_address, prepopulator: :build_shipping_address, populate_if_empty: ShippingAddress do
    property :first_name
    property :last_name
    property :country
    property :city
    property :address
    property :phone
    property :zip

    extend ActiveModel::ModelValidations
    copy_validations_from Address
  end

  def validate(params)
    params = params.merge(shipping_address: params[:billing_address]) if params[:shipping_address].nil?
    super
  end

  private

  def build_billing_address(*)
    return if self.billing_address
    return self.billing_address = BillingAddress.new(billing_address_attributes) if user.billing_address

    self.billing_address = BillingAddress.new
  end

  def build_shipping_address(*)
    return if self.shipping_address
    return self.shipping_address = ShippingAddress.new(shipping_address_attributes) if user.shipping_address

    self.shipping_address = ShippingAddress.new
  end

  def billing_address_attributes
    user.billing_address.attributes.except('id', 'order_id', 'user_id', 'created_at', 'updated_at')
  end

  def shipping_address_attributes
    user.shipping_address.attributes.except('id', 'order_id', 'user_id', 'created_at', 'updated_at')
  end
end
