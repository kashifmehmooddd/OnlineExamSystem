# frozen_string_literal: true

class StudentScoreController < ApplicationController
  def index
    @student_scores = policy_scope(StudentScore)
  end

  def show
    @student_score = StudentScore.find(params[:id])
    @questions = Question.where(exam_id: @student_score.exam_id)
  end
end
