FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "jsmith_#{n}@example.com" }
    sequence(:password) { 'password' }
    sequence(:username) { |n| "john_#{n}" }
  end
end
