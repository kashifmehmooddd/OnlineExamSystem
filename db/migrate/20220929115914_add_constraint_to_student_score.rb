# frozen_string_literal: true

class AddConstraintToStudentScore < ActiveRecord::Migration[5.2]
  def change
    change_column_null :student_scores, :score, false
  end
end
