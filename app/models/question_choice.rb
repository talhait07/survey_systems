class QuestionChoice < ApplicationRecord
  validates_presence_of :title, :question_id

  belongs_to :question
end
