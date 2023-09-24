# frozen_string_literal: true

class StudentScore < ApplicationRecord
  validates :score, presence: true
  belongs_to :student
  belongs_to :exam
end
