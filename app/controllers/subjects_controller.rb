class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :update, :destroy]

  def index
    json_response(Subject.all)
  end

  def show
    json_response(@subject)
  end

  def create
    @subject = Subject.create!(subject_params)
    json_response(@subject, :created)
  end

  def update
    @subject.update(subject_params)
    head :no_content
  end

  def destroy
    @subject.destroy
    head :no_content
  end

  private
  
  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.permit(:name)
  end
end
