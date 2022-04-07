FactoryBot.define do
  factory :comment do
    user
    post
    sequence(:body) { |n| "sample comment #{n}" }
  end
end
