class Score < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates_presence_of :student_id, :subject_id
end
