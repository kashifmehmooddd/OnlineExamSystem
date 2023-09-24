# frozen_string_literal: true

class UserAnswer < ApplicationRecord
  validates :answers, presence: true
  belongs_to :question
  belongs_to :student
end
