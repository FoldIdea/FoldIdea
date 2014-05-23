# application startup
jQuery ->
  isTouch = (('ontouchstart' in window) || (navigator.msMaxTouchPoints > 0))
  $('body').addClass('touch') if isTouch
