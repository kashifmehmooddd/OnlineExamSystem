# frozen_string_literal: true

class AddConstraintToSubject < ActiveRecord::Migration[5.2]
  def change
    change_column_null :subjects, :title, false
  end
end
