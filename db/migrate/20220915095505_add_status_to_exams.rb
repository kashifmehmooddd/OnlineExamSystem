# frozen_string_literal: true

class AddStatusToExams < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :status, :integer, default: 0
  end
end
