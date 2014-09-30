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

  def link_to_modal(content, path, target='#modal-sm', opts={})
    opts.merge!({'data-toggle' => 'modal', 'data-target' => target})
    link_to content, with_query(path, {layout: false}), opts
  end

  def with_query(str_url, hash_query)
    require 'uri'
    uri =  URI.parse(str_url)
    new_query_ar = URI.decode_www_form(uri.query || '')
    hash_query.each {|k,v| new_query_ar << [k, v] }
    uri.query = URI.encode_www_form(new_query_ar)
    uri.to_s
  end
end
