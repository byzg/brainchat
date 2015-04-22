#  ----- create -----  #
$ ->
  $('body').on 'click', 'form#new_chat input.js-submit[type="submit"]', (e) ->
    e.preventDefault()
    form = $(@).closest('form')
    params =
      dataType: 'json'
      success: (data)->
        if data['success']
          $('#chats-index ul.media-list').append(data['new_chat'])
          $('.jquery-modal.blocker').click()
        else          
          form = $('form#new_chat')
          prependAlert = -> form.prepend(data['errors'])
          closeBtn = form.find('.alert-block button.close')
          if (closeBtn.length > 0) 
            closeBtn.click()
            prependAlert()
          else 
            prependAlert() 
    formAjaxSubmit(form, params)