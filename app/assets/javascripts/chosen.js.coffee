no_results_text = ->
  switch $('input#locale').val()
    when 'ru' then 'Результатов нет'
    when 'en' then 'No results match'
    else 'Результатов нет'

runChosen = ->
  chosenSelect = $('.chosen-select')
  unless chosenSelect.length == 0
    $('.chosen-select').chosen
      allow_single_deselect: true
      no_results_text: no_results_text()
      width: '200px'

runChosen()
$('a[rel="modal:open"]').click ->
  if AbstractChosen.browser_is_supported()
    modalCurrent = []
    tred = 0
    intervalID = setInterval( ->
      tred++
      modalCurrent = $('.modal.current') if modalCurrent.length == 0
      if modalCurrent.length != 0
        runChosen()
        if $('.modal.current .chosen-select').attr('style') == "display: none;"
          clearInterval(intervalID)
      clearInterval(intervalID) if tred > 300
    , 150)