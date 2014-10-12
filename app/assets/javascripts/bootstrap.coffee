$('body').on 'mouseenter', '*[data-toggle="tooltip"]', ->
  $(@).tooltip('show')
$('body').on 'mouseleave', '*[data-toggle="tooltip"]', ->
  $(@).tooltip('hide')

collapseHideAreas = [
  'nav.navbar a[rel="modal:open"]',
  'body>.container',
  '.modal.current'
].join(', ')
collapses = $('nav.navbar .collapse.navbar-collapse')
$('html').on 'click', collapseHideAreas, ->
  if collapses.hasClass('in')
    collapses.collapse('hide')