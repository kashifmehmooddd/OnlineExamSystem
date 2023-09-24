# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @questions = Exam.find(params[:exam_id]).questions.all
  end

  def new
    @question = Exam.find(params[:exam_id]).questions.new
    @exam = Exam.find(params[:exam_id])
    authorize @question
  end

  def create
    @question = Exam.find(params[:exam_id]).questions.new(question_params)
    @exam = Exam.find(params[:exam_id])
    temp = params.fetch(:question)

    if @question.save
      @exam.update(score: @exam.score + @question.score)
      save_options(temp['opts'], @question)
      flash[:notice] = 'Sucessfully created a question'
      redirect_to exam_path(@question.exam_id)
    else
      add_alert(@question)
      redirect_to new_exam_question_path(params[:exam_id])
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @exam = Exam.find(params[:exam_id])
    return unless @question.destroy

    @exam.update(score: @exam.score - @question.score)
    flash[:notice] = 'Question has been deleted'
    redirect_to "/exams/#{params[:exam_id]}"
  end
end

  private

def question_params
  params.require(:question).permit(:description, :exam_id, :answer, :score, :base)
end

def save_options(options, question)
  return unless question.base == 'MCQ'

  options.each do |i|
    Option.create(description: i, question_id: question.id)
  end
end

def add_alert(questions)
  questions.errors.full_messages.each do |message|
    if flash[:alert].present?
      flash[:alert] << ', ' << message
    else
      flash[:alert] = message
    end
  end
end
