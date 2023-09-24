# frozen_string_literal: true

class AddScoreToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :score, :integer
  end
end
