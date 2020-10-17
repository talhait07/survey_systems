FactoryBot.define do
  factory :answer do
    response { Faker::Lorem.word }
    question_id { nil }
  end
end
