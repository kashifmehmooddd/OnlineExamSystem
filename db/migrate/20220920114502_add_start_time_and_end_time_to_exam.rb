# frozen_string_literal: true

class AddStartTimeAndEndTimeToExam < ActiveRecord::Migration[5.2]
  def change
    change_table :exams, bulk: true do |t|
      t.column :start_time, :datetime
      t.column :end_time, :datetime
    end
  end
end
