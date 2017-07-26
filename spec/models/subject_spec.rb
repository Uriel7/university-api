require 'rails_helper'

RSpec.describe Subject, type: :model do
  # Test relationships
  it { should have_many(:scores).dependent(:destroy) }
  # Validation test
  # Ensure the column name cant be empty before save
  it { should validate_presence_of(:name) }
end
