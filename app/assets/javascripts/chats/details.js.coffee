#  ----- details -----  #
class Chats
  SELECTORS =
    listParent: '#chat_list'
    list: '#chat_list tr'
    detailsTable: '.details-table'
    loading: '.details-table .loading'
    details: '.details-table .details'
    currentClass: 'info'
  $list = null
  $listParent = $(SELECTORS.listParent)
  $html_list = $(SELECTORS.list)
  $detailsTable = $(SELECTORS.detailsTable)
  $loading = $(SELECTORS.loading)
  $details = $(SELECTORS.details)
  $limits =
    listTop: $listParent.offset().top
    listBottom: $listParent.offset().top + $listParent.height()
    screenBottom: -> $(window).scrollTop() + $(window).height()

  constructor: ->
    if $html_list.length > 0
      @list = initList($html_list)
      $list = @list
      @current = @list[lsProcess()]
      _select = @select
      $html_list.click ->
        _select($(@))
      @select(@current)

  select: (tr) =>
    @current.removeClass(SELECTORS.currentClass)
    @current = tr
    @current.addClass(SELECTORS.currentClass)
    $details.hide()
    $loading.show()
    move(@current)
    $.ajax(
      url: @current.data('link')
      method: 'GET'
    )
    .done (answer) ->
      $loading.hide()
      $details.html(answer)
      $details.show()
      move(tr)
    lsProcess(@current.attr('id'))
    @current

  initList = (html_list)->
    result = {}
    $.each html_list, (_, tr) =>
      tr = $(tr)
      result[tr.attr('id')] = tr
    result

  lsProcess = (current_id = null)->
    first_id = ($.map($list, (_, id)-> id))[0]
    ls = new LS('chats')
    if ls.isAvailable()
      lsHash = ls.pull() || {current_id: null}
      unless current_id
        current_id = lsHash.current_id || first_id
      lsHash.current_id = current_id
      ls.push(lsHash)
    else
      current_id = first_id
    current_id

  move = (current) ->
    newTop = current.offset().top
    newBottom = -> newTop + $detailsTable.height()
    if newBottom() > $limits.screenBottom()
      newTop = $limits.screenBottom() - $detailsTable.height()
    if newBottom() > $limits.listBottom
      newTop = $limits.listBottom - $detailsTable.height()
    newTop -= $limits.listTop
    newTop = 0 if newTop < 0
    $detailsTable.css('top', newTop + 'px')

$ ->
  chats = new Chats()
  $('body').on 'click', '.details-table .update-current-chat', ->
    chats.select(chats.current)
