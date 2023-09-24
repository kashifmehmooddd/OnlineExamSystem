# frozen_string_literal: true

class AddBaseToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :base, :integer
  end
end
