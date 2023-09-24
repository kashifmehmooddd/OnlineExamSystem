# frozen_string_literal: true

class AddKeyToStudentScores < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :student_scores, :exams, column: :exam_id
    add_foreign_key :student_scores, :users, column: :student_id
  end
end
