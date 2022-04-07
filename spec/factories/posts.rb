FactoryBot.define do
  factory :post do
    user
    sequence(:title) { |n| "sample post #{n}" }
    sequence(:body) { 'Hello' }
  end
end
