# frozen_string_literal: true

class AddIndexToExams < ActiveRecord::Migration[5.2]
  def change
    add_index :exams, :exam_code, unique: true
  end
end
