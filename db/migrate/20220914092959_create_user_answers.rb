# frozen_string_literal: true

class CreateUserAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_answers do |t|
      t.text :answers
      t.timestamps
    end
  end
end
