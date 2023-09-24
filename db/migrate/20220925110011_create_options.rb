# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.string :description
      t.timestamps
    end
  end
end
