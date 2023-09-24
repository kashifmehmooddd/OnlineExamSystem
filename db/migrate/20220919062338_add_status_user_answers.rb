# frozen_string_literal: true

class AddStatusUserAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_answers, :status, :boolean
  end
end
