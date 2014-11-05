# application startup
jQuery ->
  isTouch = (('ontouchstart' in window) || (navigator.msMaxTouchPoints > 0))
  if isTouch
    $('body').addClass('touch')
  else
    $('body').addClass('notouch')
  end
