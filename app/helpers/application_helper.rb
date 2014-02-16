module ApplicationHelper
  require 'cgi'
  def details_table(details = {}, html_opt = {}, left_col = 3, right_col = 9)
    table = ''
    details.each_pair do |k, v|
      tr= content_tag :tr do
        concat content_tag :td, k, class: "span#{left_col}"
        concat content_tag :td, v, class: "span#{right_col}"
      end
      table += tr
    end
    content_tag :table, table.html_safe, html_opt
  end
end
