# frozen_string_literal: true

class UserAnswersController < ApplicationController
  before_action :set_user_status, only: :create

  def new
    @exam = Exam.find(params[:exam_id])
    @questions = Question.where(exam_id: params[:exam_id])
    @question_ids = @questions.pluck(:id)
    @user_answer = UserAnswer.new
    @student_score = StudentScore.where(exam_id: params[:exam_id], student_id: current_user.id).exists?
    authorize @user_answer
  end

  def create
    if StudentScore.where(student_id: current_user.id, exam_id: params[:exam_id]).exists?
      redirect_to exams_path
      flash[:alert] = 'You have already submitted that exam X'
    else
      temp = params.fetch(:user_answer)
      @questions = Question.where(exam_id: params[:exam_id])
      score = 0
      temp['answers'].length.times do |i|
        status = @questions.find(temp['question_id'][i]).answer == temp['answers'][i]
        score += @questions.find(temp['question_id'][i]).score if status
        UserAnswer.create!(
          answers: temp['answers'][i],
          question_id: temp['question_id'][i],
          student_id: current_user.id,
          status: status
        )
      end
      add_score(score)
    end
  end

  private

  def set_user_status
    current_user.update(exam_status: false)
  end

  def add_score(scor)
    @student_score = StudentScore.create(score: scor, student_id: current_user.id, exam_id: params[:exam_id])
    redirect_to student_score_path(@student_score)
    flash[:notice] = 'Exam has been submitted! :)'
  end
end
