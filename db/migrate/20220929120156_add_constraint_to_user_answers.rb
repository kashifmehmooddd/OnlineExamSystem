# frozen_string_literal: true

class AddConstraintToUserAnswers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :user_answers, :answers, false
    change_column_null :user_answers, :status, null: false
    change_column_default :user_answers, :status, to: false, from: nil
  end
end
