class Answer < ApplicationRecord
  validates_presence_of :question_id, :response

  belongs_to :question
end
