module PagesHelper
  def user_can_create?
     current_user && current_user.premium?
  end

  def user_can_edit_and_delete?(page)
      current_user && (current_user == page.user || current_user.admin?)
  end

end
