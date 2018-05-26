module PagesHelper
  def user_can_create?
     current_user
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

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true,
      underline: true,
      highlight: true,
      strikethrough: true,
      superscript: true,
      footnotes: true,
      footnote_def: true,
      list: true,
      tables: true,
      quote: true
    })
    @markdown.render(content)
  end
end
