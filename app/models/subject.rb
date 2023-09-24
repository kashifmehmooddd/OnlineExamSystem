# frozen_string_literal: true

class Subject < ApplicationRecord
  validates :title, uniqueness: true, presence: true

  has_many :exams, dependent: :destroy
end
