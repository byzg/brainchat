$ ->
  if $('#chat_list')
    details_title = $('h5').eq(1).text().match(/^.+:/)
    user_names_title = $('h6').text().match(/^.+:/)
    $('tr.cursor-pointer').eq(0).addClass('info')
    $('tr.cursor-pointer').click ->
      $(this).parent().parent().find('tr.info').removeClass('info')
      $(this).addClass('info')
      $('h5').eq(1).text("#{details_title} #{$(this).find('td').eq(1).find('div').text()}")
      $.ajax(
        url: $(this).data('link')
        method: 'GET'
      ) .done (data) ->
        insert_to_table = (row, text, default_text = null) ->
          text ||= default_text || '-'
          $('table.details_table tr').eq(row).find($('td')).eq(1).find('div').text(text)
        insert_to_table(0, data['created_at'])
        insert_to_table(1, data['owner_name'])
        insert_to_table(2, data['messages_count'], '0')
        insert_to_table(3, data['last_message'])
        $('h6').text("#{user_names_title} #{data['users_names']}")

