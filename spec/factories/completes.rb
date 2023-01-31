FactoryBot.define do
  factory :complete do
    done { Time.zone.now }
    memo { "MyText" }
    again { 0 }
    status { 0 }
    association :user
    association :post
  end
end
