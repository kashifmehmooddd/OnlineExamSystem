# frozen_string_literal: true

class AddQuestionToOptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :options, :question, index: true
  end
end
