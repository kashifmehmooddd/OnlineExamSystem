# frozen_string_literal: true

class AddConstraintToExams < ActiveRecord::Migration[5.2]
  def change
    change_column_null :exams, :exam_code, false
    change_column_null :exams, :start_time, false
    change_column_null :exams, :start_time, false
    change_column_default :exams, :score, to: 0, from: nil
  end
end
