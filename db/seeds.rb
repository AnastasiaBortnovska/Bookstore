# frozen_string_literal: true

['Nova Poshta', 'Ukr Poshta', 'DHL'].each do |name|
  Delivery.create(
    name: name,
    days: rand(14),
    price: rand(10.0..50.0).floor(2)
  )
end
