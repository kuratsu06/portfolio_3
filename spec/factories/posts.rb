FactoryBot.define do
  factory :post do
    title { "MyString" }
    memo { "MyText" }
    status { 0 }
    association :user
    association :category
  end
end
