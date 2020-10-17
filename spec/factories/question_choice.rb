FactoryBot.define do
  factory :question_choice do
    title { Faker::Lorem.word }
    question_id { nil }
  end
end
