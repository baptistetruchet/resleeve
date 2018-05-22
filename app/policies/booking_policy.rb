class BookingPolicy < ApplicationPolicy

  def create?
    return true
  end

  def edit?
    record.user == user || user.admin
  end

  def update?
    record.user == user || user.admin
  end

  def destroy?
    record.user == user || user.admin
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
