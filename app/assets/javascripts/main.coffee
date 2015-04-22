window.scrollToBottom = ->
  $(window).scrollTop($(document).height())       # works without bamboo
  $('.scroller').scrollTo($(document).height())   # works with bamboo

window.formAjaxSubmit = (formEl, additionalData = {})->
  params = 
    type: formEl.attr('method')
    url: formEl.attr('action')
    data: formEl.serialize()
  $.extend params, additionalData
  $.ajax params