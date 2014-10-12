#  ----- create -----  #
$ ->
  $('body').on 'click', 'form#new_chat input.js-submit[type="submit"]', (e) ->
    e.preventDefault()
    $(@).closest('form').ajaxSubmit()