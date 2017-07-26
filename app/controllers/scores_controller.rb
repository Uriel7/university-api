class ScoresController < ApplicationController
  before_action :set_student
  before_action :set_student_score, only: [:show, :update, :destroy]
  def index
    json_response(@student.scores)
  end

  def show
    json_response(@score)
  end

  def create
    @score = @student.scores.create!(score_params)
    json_response(@score, :created)
  end

  def update
    @score.update(score_params)
  end

  def destroy
  end

  private
  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_student_score
    @score = @student.scores.find_by!(id: params[:id]) if @student
  end

  def score_params
    params.permit(:student_id, :subject_id, :qualification)
  end
end
