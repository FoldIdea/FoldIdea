module ApplicationHelper
  def site_name
    '<span class="smcaps w_lt">Fold</span><span class="smcaps w_rt">Idea</span>'.html_safe
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def body_style(style)
    content_for :body_style, style.to_s
  end
end
