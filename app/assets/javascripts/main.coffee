window.scrollToBottom = ->
  $(window).scrollTop($(document).height())       # works without bamboo
  $('.scroller').scrollTo($(document).height())   # works with bamboo