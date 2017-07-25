class Student < ApplicationRecord
  has_many :scores, dependent: :destroy

  validates_presence_of :name, :surname, :birthdate
end
