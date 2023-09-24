# frozen_string_literal: true

class AddQuestionToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_answers, :question, index: true
  end
end
