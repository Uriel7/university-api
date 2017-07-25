class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]
  def index
    @students = Student.all
    json_response(@students)
  end

  def show
    json_response(@student)
  end

  def create
    @student = Student.create!(student_params)
    json_response(@student, :created)
  end

  def update
    @student.update(student_params)
    head :no_content
  end

  def destroy
    @student.destroy
    head :no_content
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.permit(:name, :surname, :birthdate)
  end
end
