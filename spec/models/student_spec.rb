require 'rails_helper'

RSpec.describe Student, type: :model do
  # association test
  # ensure Student has a 1:m relationship with Score model
  it { should have_many(:scores).dependent(:destroy) }

  # validation
  # ensure columns name, surnames and birthdate are present before save
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:birthdate) }
end
