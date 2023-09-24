# frozen_string_literal: true

class StudentScorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.teacher?
        scope.where(exam_id: user.exams.ids)
      elsif user.student?
        scope.where(student_id: user.id)
      else
        scope.all
      end
    end
  end
end
