# frozen_string_literal: true

class ExamPolicy < ApplicationPolicy
  def pendings?
    user.admin?
  end

  def new?
    user.teacher?
  end

  def finished?
    user.teacher? || user.admin?
  end

  def teacher_action?(status)
    user.teacher? && %w[creation ready].include?(status)
  end

  def admin_action?(status)
    user.admin? && %w[approved cancel].include?(status)
  end

  def exam_edit?(start, status)
    user.teacher? && DateTime.now < start && (status != 'approved' && status != 'cancel')
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.where(status: 'ready')
      elsif user.teacher?
        scope.where(status: %w[ready creation], teacher_id: user.id)
      else
        scope.none
      end
    end
  end
end
