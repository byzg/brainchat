$(document).ready ->
  if ($('#chat-container').length)
    lastMessage = $('li.media').last()
    if (lastMessage.length)
      tLastMessage = parseInt(lastMessage.offset().top + lastMessage.css('height'))
      $('#chat-history').scrollTop(tLastMessage);
#     request_chat_id = $('input#request_chat_id[type=hidden]').val()

#     check_email_timer_id = setInterval () ->
#       $.ajax(
#         url: "/messages/check_email?request_chat_id=#{request_chat_id}"
#         dataType: 'json'
#         cache: false
#         method: 'GET'
#       ).done (data) ->
#         if (data['messages'])
#           if !(data['messages'] == 'none')
#             $('#chat-history').append(data['messages']);
#             $('#chat-history').scrollTop($('#chat-history').scrollTop()+parseInt($('.chat-history-message').last().css('height')));
#             $('#form_message textarea').val('');
#             $('#form_message textarea').focus();
#         else
#           alert(data['error']);
#           clearInterval(check_email_timer_id);
#           location.reload()
#     ,10000