#= require bootstrap/affix
#= require bootstrap/alert
#= require bootstrap/button
#= require bootstrap/carousel
#= require bootstrap/collapse
#= require bootstrap/dropdown
#= require bootstrap/tab
#= require bootstrap/transition
#= require bootstrap/scrollspy
#= require bootstrap/modal
#= require bootstrap/tooltip
#= require bootstrap/popover

ajaxLoaderProcess = ->
  ajaxLoader = $('.ajax-loader')
  doc = $(document)
  needToShowAjaxLoader = false
  $('a[data-toggle="modal"], button[data-toggle="modal"]').click ->
    needToShowAjaxLoader = true
  doc.ajaxSend ->
    ajaxLoader.show() if needToShowAjaxLoader
    needToShowAjaxLoader = false
  doc.ajaxComplete ->
    ajaxLoader.hide()
  doc.ajaxError ->
    ajaxLoader.hide()

$(document).ready ->
  ajaxLoaderProcess()