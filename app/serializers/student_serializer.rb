class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :birthdate

  has_many :scores
end
