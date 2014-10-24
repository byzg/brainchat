window.LS = class LS
  constructor: (@highKey) ->

  isAvailable: ->
    try
      return "localStorage" of window and window["localStorage"] isnt null
    catch e
      return false

  push: (object) ->
    localStorage[@highKey] = JSON.stringify(object)

  pull: ->
    try
      JSON.parse(localStorage[@highKey])
    catch
      null