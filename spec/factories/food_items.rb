FactoryBot.define do
  factory :food_item, class: FoodItem do
    name { "fooditem" }
    price { 100.45 }
    restaurant_id { create(:restaurant).id }
  end
end