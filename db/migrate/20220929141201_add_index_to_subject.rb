# frozen_string_literal: true

class AddIndexToSubject < ActiveRecord::Migration[5.2]
  def change
    add_index :subjects, :title, unique: true
  end
end
