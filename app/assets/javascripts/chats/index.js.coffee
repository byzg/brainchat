# ----- details -----  #
$(document).ready ->
  if gon.current_user.logged_in && $('#chats-index').length > 0
    $ ->
      setTruncateWidth = ->
        bodyWidth = $('body').width()
        truncateleft = $('.truncate').offset().left
        $('.truncate').css('max-width', bodyWidth - 2 * truncateleft)
      setTruncateWidth()
      $('body').on 'click', '.message', ->
        location.href = $(@).attr('data-link')