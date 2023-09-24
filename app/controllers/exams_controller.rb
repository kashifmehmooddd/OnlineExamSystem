# frozen_string_literal: true

class ExamsController < ApplicationController
  before_action :find_exam, only: %i[show edit update_status update destroy]

  def index
    @exams = Exam.where(status: 'approved').where('end_time > ?', DateTime.now)
  end

  def new
    @exam = Exam.new
    @subjects = Subject.all
    authorize @exam

    return unless current_user.exams.where(status: %w[creation ready]).exists?

    flash[:alert] = 'You have already one exam in progress!'
    redirect_to exams_path
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      redirect_to new_exam_question_path(@exam.id)
      flash[:notice] = 'Exam has been created. Now, add questions to it!'
    else

      add_alert(@exam.errors.full_messages)
      redirect_to new_exam_path
    end
  end

  def show
    @questions = @exam.questions
  end

  def update_status
    @exam.status = params[:status]
    redirect_to @exam if @exam.save(validate: false)
  end

  def restart_exam
    current_user.update(exam_status: false)
    redirect_to new_exam_user_answer_path(params[:id])
  end


  def edit; end


  def update
    if @exam.update(exam_params)
      redirect_to exams_path
    else
      add_alert(@exam.errors.full_messages)
      redirect_to edit_exam_path(params[:id])
    end
  end

  def destroy
    return unless @exam.destroy

    flash[:notice] = "Exam #{@exam.exam_code} has been deleted!"
    redirect_to exams_path
  end

  def pendings
    @exams = policy_scope(Exam)
    authorize @exams
  end

  def creations
    @exams = policy_scope(Exam)
  end

  def finished
    @exams = if current_user.type == 'Teacher'
               Exam.where(status: 'approved').where('end_time < ?', DateTime.now).where(teacher_id: current_user.id)
             else
               Exam.where(status: 'approved').where('end_time < ?', DateTime.now)
             end
  end

  private

  def find_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:exam_code, :subject_id, :score, :start_time, :end_time, :teacher_id)
  end

  def add_alert(errors)
    errors.each do |message|
      if flash[:alert].present?
        flash[:alert] << ', ' << message
      else
        flash[:alert] = message
      end
    end
  end

  def add_alert(errors)
    errors.each do |message|
      if flash[:alert].present?
        flash[:alert] << ', ' << message
      else
        flash[:alert] = message
      end
    end
  end
end
