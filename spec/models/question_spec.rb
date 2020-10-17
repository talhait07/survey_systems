require 'rails_helper'

RSpec.describe Question, type: :model do
  # Association test
  it { should belong_to(:survey) }

  it { should have_many(:question_choices).dependent(:destroy) }
  it { should have_many(:answers) }

  # Validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:survey_id) }

  # validate question_type
  it { should allow_values(:input_text, :multiple_choice, :single_choice).for(:question_type) }
end
