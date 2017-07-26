FactoryGirl.define do
  factory :score do
    student_id nil
    subject_id nil
    qualification Faker::Number.number(10)
  end
end