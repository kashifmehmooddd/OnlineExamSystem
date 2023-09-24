# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :full_name, presence: true
  validates :email, presence: true

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable
  has_one_attached :avatar, dependent: :purge
  validates :avatar, blob: { content_type: %w[image/png image/jpeg] }

  %i[admin student teacher].each do |method|
    define_method("#{method}?") do
      type == method.capitalize.to_s
    end
  end
end
