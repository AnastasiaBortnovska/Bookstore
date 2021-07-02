FactoryBot.define do
  factory :delivery do
    name { FFaker::Name.first_name }
    days { rand(10) }
    price { rand(10.0..150.0).floor(2) }
  end
end
