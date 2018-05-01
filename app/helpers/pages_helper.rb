module PagesHelper
  def user_can_create?
     (current_user && current_user.premium?) || (current_user && current_user.standard?)
  end

  def user_can_edit_and_delete?(page)
      current_user && (current_user == page.user || current_user.admin?)
  end

  def user_is_authorized_for_private?
    current_user.premium? || current_user.admin?
  end

  def private_title(page)
    if page.private
      "PRIVATE: #{page.title}"
    else
      page.title
    end
  end
end
