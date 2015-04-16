$(document).ready ->
  #bamboo
  if $('.bamboo-menu').length > 0
    $('nav.navbar.navbar-fixed-top').width($('body').width())
    site = new Bamboo