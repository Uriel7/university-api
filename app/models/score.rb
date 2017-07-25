class Score < ApplicationRecord
  belongs_to :student, dependent: :destroy
  belongs_to :subject
end
