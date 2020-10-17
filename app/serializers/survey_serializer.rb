class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at

  has_many :questions, serializer: QuestionAndAnswerSerializer
end
