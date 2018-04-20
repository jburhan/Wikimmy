class PagePolicy
  attr_reader :user, :page

  def initialize(user, page)
    @user = user
    @page = page
  end

  def create?
    user.premium?
  end

  def update?
    user.admin? || page.user == user
  end

  def destroy?
    user.admin? || page.user == user
  end


end
