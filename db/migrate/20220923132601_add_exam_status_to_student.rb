# frozen_string_literal: true

class AddExamStatusToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :exam_status, :boolean, default: false
  end
end
