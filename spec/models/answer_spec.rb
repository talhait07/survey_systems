require 'rails_helper'

RSpec.describe Answer, type: :model do
  # Association test
  it { should belong_to(:question) }

  # Validation tests
  it { should validate_presence_of(:response) }
  it { should validate_presence_of(:question_id) }
end
