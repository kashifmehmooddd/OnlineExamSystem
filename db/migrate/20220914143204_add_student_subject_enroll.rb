# frozen_string_literal: true

class AddStudentSubjectEnroll < ActiveRecord::Migration[5.2]
  def change
    add_reference :enrolls, :subject, index: true
    add_reference :enrolls, :student, index: true
  end
end
