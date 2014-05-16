# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#jQuery ->
# NOTE: jQuery -> does not work correctly with TurboLinks.
# see here: http://stackoverflow.com/questions/21219357/rails4-and-coffeescript-jquery-bindings-not-working-when-server-returns-304-sta
$(document).bind 'page:change', ->
  for trayC in $('.tray .tr_bg')
    trayBG = $(trayC)
    wd = trayBG.innerWidth()
    ht = trayBG.innerHeight()
    trayBG.css padding:0, width:"#{wd}px", height:"#{ht}px"
    bgImg = trayBG.find 'img'
    bgImg.load ->
      iwd = bgImg.width()
      iht = bgImg.height()
      cellWd = parseInt(wd / iwd + 0.99)
      cellHt = parseInt(ht / iht + 0.99)
      newIwd = cellWd * iwd + 10
      newIht = cellHt * iht + 10
      imgSrc = bgImg.attr 'src'
      newHtml = '<div style="width:' + newIwd + 'px; height:' + newIht + 'px; line-height:1px;">'
      for row in [1..cellHt]
        a = row
        for col in [1..cellWd]
          newHtml += '<img src="' + imgSrc + '"/>'
        newHtml += '<br/>'
      newHtml += '</div>'
      trayBG.html newHtml
