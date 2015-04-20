$(document).ready ->
  if $('#chat-container').length > 0        
    setTimeout ->
      scrollToBottom()                       # works without bamboo
      $('.scroller').scrollTo('textarea')    # works with bamboo
    , 100


    request_chat_id = $('input#request_chat_id[type=hidden]').val()
    check_email_timer_id = setInterval ->
      $.ajax(
        url: "/messages/check_email?request_chat_id=#{request_chat_id}"
        dataType: 'json'
        cache: false
        method: 'GET'
      ).done (data) ->
        if (data['messages'])
          if !(data['messages'] == 'none')
            $('ul#chat-history').append(data['messages']);
            scrollToBottom()
        else
          alert(data['error']);
          clearInterval(check_email_timer_id);
          location.reload()
    , 10000