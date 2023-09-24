# frozen_string_literal: true

class AddUserToUseranswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_answers, :student, index: true
  end
end
