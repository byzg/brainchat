jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $('table').addClass('table table-hover table-striped table-bordered .table-condensed')
  $('table td, table th').wrapInner('<div class="text-center" />')