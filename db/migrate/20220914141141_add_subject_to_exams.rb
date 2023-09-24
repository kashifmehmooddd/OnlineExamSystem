# frozen_string_literal: true

class AddSubjectToExams < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :subject, index: true
  end
end
