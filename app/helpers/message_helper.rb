module MessageHelper

  def to_html(text)
    h(text).gsub("\n", "<br>").html_safe
  end

end