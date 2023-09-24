# frozen_string_literal: true

class AddConstraintToOptions < ActiveRecord::Migration[5.2]
  def change
    change_column_null :options, :description, false
  end
end
