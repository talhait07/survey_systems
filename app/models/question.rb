class Question < ApplicationRecord
  QUESTION_TYPE = { text: 'input_text',
                    single: 'single_choice',
                    multiple: 'multiple_choice'
                  }.freeze

  validates_presence_of :title, :survey_id
  validates :question_type, inclusion: { in: QUESTION_TYPE.values }

  belongs_to :survey
  has_many :question_choices, dependent: :destroy
  has_many :answers

end
