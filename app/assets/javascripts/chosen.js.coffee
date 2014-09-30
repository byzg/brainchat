no_results_text = ->
  switch $('input#locale').val()
    when 'ru' then 'Результатов нет'
    when 'en' then 'No results match'
    else 'Результатов нет'

runChosen = ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: no_results_text()
    width: '200px'

$( document ).ready ->
  runChosen()
  $('a[data-toggle="modal"], button[data-toggle="modal"]').click ->
    intervalID = setInterval( ->
      chosenSelect = $('.chosen-select')
      if $('.modal[style="display: block;"]').length != 0 && chosenSelect.length != 0
        runChosen()
        clearInterval(intervalID) if chosenSelect.attr('style') == "display: none;"
    , 500)