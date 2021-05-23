FactoryBot.define do
  factory :comment do
    text { 'すごいですね' }
    association :user
    association :tweet
  end
end
