# frozen_string_literal: true

class UserAnswerPolicy < ApplicationPolicy
  def new?
    user.student?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
