class QuestionAndAnswerSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :answers, :serializer => AnswerSerializer
end
