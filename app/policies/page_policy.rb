class PagePolicy
  attr_reader :user, :page

  def initialize(user, page)
    @user = user
    @page = page
  end

  def index?
  end

  def create?
    user.premium?|| user.standard?
  end

  def new?
    user.premium? || user.standard?
  end

  def update?
    user.admin? || page.user == user
  end

  def edit?
    user.admin? || page.user == user
  end

  def destroy?
    user.admin? || page.user == user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      pages = []
      if user.role == 'admin'
        pages = scope.all
      elsif user.role == 'premium'
        all_pages = scope.all
        all_pages.each do |page|
          if page.user == user || page.collaborators.pluck(:user_id).include?(user.id)
            pages << page
          end
        end
      else
        all_pages = scope.all
        pages = []
        all_pages.each do |page|
          if page.collaborators.pluck(:user_id).include?(user.id)
            pages << page
          end
        end
      end
      pages
    end
  end


end
