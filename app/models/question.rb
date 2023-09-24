# frozen_string_literal: true

class Question < ApplicationRecord
  validates :description, presence: true
  validates :answer, presence: true
  validates :score, presence: true
  validates :base, presence: true

  belongs_to :exam

  has_many :user_answers, dependent: :destroy
  has_many :students, through: :user_answers, dependent: :destroy

  has_many :options,  dependent: :destroy

  validate :mcq_answer

  enum base: { text: 0, MCQ: 1 }

  def mcq_answer
    return unless base == 'MCQ' && %w[1 2 3 4].exclude?(answer)

    errors.add :answer,
               ' should be in the option numbers'
  end
end
