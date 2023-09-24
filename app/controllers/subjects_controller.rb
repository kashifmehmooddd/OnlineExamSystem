# frozen_string_literal: true

class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
    authorize @subjects
  end

  def new
    @subject = Subject.new
    authorize @subject
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to subjects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:title)
  end
end
