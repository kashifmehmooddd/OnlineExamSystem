# frozen_string_literal: true

class DropEnrolls < ActiveRecord::Migration[5.2]
  def up
    drop_table :enrolls
  end

  def down
    create_table :enrolls, &:timestamps
  end
end
