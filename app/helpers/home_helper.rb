module HomeHelper
  def pretty_print(text)
    (auto_link(text, :all, target: '_blank', rel: 'nofollow').gsub("\n", '<br/>').gsub(/<br\/> +/) { |mtch| '<br/>'+"&nbsp;"*(mtch[5..-1].length) }).html_safe
  end
end
