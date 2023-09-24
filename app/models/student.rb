# frozen_string_literal: true

class Student < User
  has_many :student_scores, dependent: :destroy
  has_many :exams, through: :student_scores, dependent: :destroy

  has_many :user_answers, dependent: :destroy
  has_many :questions, through: :user_answers, dependent: :destroy
end
