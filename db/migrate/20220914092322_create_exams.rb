# frozen_string_literal: true

class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :exam_code
      t.integer :score

      t.timestamps
    end
  end
end
