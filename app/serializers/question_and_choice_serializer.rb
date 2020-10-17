class QuestionAndChoiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :question_type

  has_many :question_choices
end
