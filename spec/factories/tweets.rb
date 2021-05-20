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
  end
end
