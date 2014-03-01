$ ->
  no_results_text = switch $('input#locale').val()
    when 'ru' then 'Результатов нет'
    when 'en' then 'No results match'
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: no_results_text
    width: '200px'
  $('a[rel="modal:open"]').click ->
    i = 1
    intervalID = setInterval( ->
      if $('.modal.current').length != 0
        $('.chosen-select').chosen({no_results_text: no_results_text})
        clearInterval(intervalID)
    , 50)