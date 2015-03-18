module ApplicationHelper
  require 'cgi'
  # def details_table(details = {}, html_opt = {}, left_col = 4)
  #   table = ''
  #   right_col = 12 - left_col
  #   details.each_pair do |k, v|
  #     tr= content_tag :tr do
  #       concat content_tag :td, k, class: "col-xs-#{left_col}"
  #       concat content_tag :td, v, class: "col-xs-#{right_col}"
  #     end
  #     table += tr
  #   end
  #   content_tag :table, table.html_safe, html_opt
  # end

  def with_query(str_url, hash_query)
    require 'uri'
    uri =  URI.parse(str_url)
    new_query_ar = URI.decode_www_form(uri.query || '')
    hash_query.each {|k,v| new_query_ar << [k, v] }
    uri.query = URI.encode_www_form(new_query_ar)
    uri.to_s
  end

  def modal?
    request.format == '*/*'
  end

  def avatar(user)
    data_url = Rails.cache.fetch("avatar_#{user.id}") do
      Identicon.data_url_for(user.id) 
    end
    image_tag data_url
  end
end
