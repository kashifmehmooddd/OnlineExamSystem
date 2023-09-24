# frozen_string_literal: true

class AddKeyToExams < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :exams, :subjects, column: :subject_id
    add_foreign_key :exams, :users, column: :teacher_id
  end
end
