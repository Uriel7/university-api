class ScoresSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :subject_id, :qualification

  belongs_to :student
  belongs_to :subject
end
