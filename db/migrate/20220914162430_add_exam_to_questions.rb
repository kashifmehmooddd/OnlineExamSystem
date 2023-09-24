# frozen_string_literal: true

class AddExamToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :exam, index: true
  end
end
