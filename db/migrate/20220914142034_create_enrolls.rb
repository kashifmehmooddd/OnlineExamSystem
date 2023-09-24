# frozen_string_literal: true

class CreateEnrolls < ActiveRecord::Migration[5.2]
  def change
    create_table :enrolls, &:timestamps
  end
end
