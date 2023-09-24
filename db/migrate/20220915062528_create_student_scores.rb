# frozen_string_literal: true

class CreateStudentScores < ActiveRecord::Migration[5.2]
  def change
    create_table :student_scores do |t|
      t.integer :score
      t.references :student
      t.references :exam
      t.timestamps
    end
  end
end
