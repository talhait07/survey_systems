class QuestionChoiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :next_question_id
end
