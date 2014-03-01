$ ->
  if $('#friend_list')
    $("select").on "change", ->
      label = $(@).parent().find('.label_of_selectbox')
      label.find('a').attr('href', "/chats/#{@value}")
      if @value then label.css('visibility', 'visible') else label.css('visibility', 'hidden')
