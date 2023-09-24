# frozen_string_literal: true

class SubjectPolicy < ApplicationPolicy
  def new?
    user.admin?
  end

  alias edit? new?
  alias index? new?

  class Scope < Scope
  end
end
