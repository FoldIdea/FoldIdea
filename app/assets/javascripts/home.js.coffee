# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).bind 'page:change', ->
  for hilite in $('.highlight')
    $(hilite).hover (ev) -> $(this).parent().toggleClass('w_sel')