class Score < ApplicationRecord
  belongs_to :student_id
  belongs_to :subject_id
end
