# frozen_string_literal: true

class AddTeacherToExam < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :teacher, index: true
  end
end
