require 'rails_helper'

RSpec.describe Survey, type: :model do
  # Association test
  it { should have_many(:questions).dependent(:destroy) }

  # Validation tests
  it { should validate_presence_of(:title) }
end
