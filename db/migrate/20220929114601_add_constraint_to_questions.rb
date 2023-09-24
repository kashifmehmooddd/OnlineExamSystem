# frozen_string_literal: true

class AddConstraintToQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column_null :questions, :description, false
    change_column_null  :questions, :answer, false
    change_column_null  :questions, :base, false
    change_column_default :questions, :score, to: 0, from: nil
  end
end
