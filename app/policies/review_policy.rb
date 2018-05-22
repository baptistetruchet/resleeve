class ReviewPolicy < ApplicationPolicy
  def create?
    # (record.booking.reviews.any? && record.booking.user == user) || user.admin
    if record.booking.reviews.first.nil?
      record.booking.user == user || user.admin
    else
      false
    end
  end

  # def edit?
  #   record.user == user || user.admin
  # end

  # def update?
  #   record.user == user || user.admin
  # end

  # def destroy?
  #   record.user == user || user.admin
  # end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
