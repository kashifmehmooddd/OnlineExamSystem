# frozen_string_literal: true

class Teacher < User
  has_one_attached :avatar

  has_many :exams, dependent: :destroy
end
