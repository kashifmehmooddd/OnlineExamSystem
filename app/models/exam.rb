# frozen_string_literal: true

class Exam < ApplicationRecord
  validates :exam_code, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :subject_id, presence: true

  validate :valid_start, :valid_end

  belongs_to :subject

  has_many :questions, dependent: :destroy

  has_many :student_scores, dependent: :destroy
  has_many :students, through: :student_scores, dependent: :destroy

  belongs_to :teacher

  enum status: { creation: 0, ready: 1, approved: 2, finished: 3, cancel: 4 }


  def valid_start
    return if !start_time.nil? && !(start_time < DateTime.now)
    errors.add :start_time,
               ' should be after current time'
  end

  def valid_end
    return if !start_time.nil? && !end_time.nil? && !(end_time < start_time)
    errors.add :end_time,
               ' should be after start time'
  end
end
