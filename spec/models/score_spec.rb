require 'rails_helper'

RSpec.describe Score, type: :model do
  # Asociations test
  it { should belong_to(:student) }
  it { should belong_to(:subject) }

  # Validation Test
  # ensure columns subject_id, student_id, are present before save
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:subject_id) }
end
