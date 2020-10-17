FactoryBot.define do
  factory :question do
    title { Faker::Lorem.word }
    survey_id { nil }
    question_type { nil }
  end
end
