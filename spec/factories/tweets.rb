FactoryBot.define do
  factory :tweet do
    title { 'テスト' }
    text { 'テストテストテスト' }
    job_id { 2 }
    status_id { 2 }
    association :user

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('public/images/sample.png'), filename: 'sample.png')
    end

    trait :tweet2 do
      title { '試験' }
      text { '試験試験試験' }
      job_id { 3 }
      status_id { 3 }
      association :user

      after(:build) do |tweet|
        tweet.image.attach(io: File.open('public/images/sample2.png'), filename: 'sample2.png')
      end
    end
  end
end
