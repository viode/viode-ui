#= require bootstrap/transition
#= require bootstrap/dropdown
#= require_tree .

$ ->
  hexc = (colorval) ->
    parts = colorval.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
    delete parts[0]
    i = 1
    while i <= 3
      parts[i] = parseInt(parts[i]).toString(16)
      if parts[i].length == 1
        parts[i] = '0' + parts[i]
      ++i
    color = '#' + parts.join('')
    return color.toUpperCase()

  $('.swatch').on('mouseenter', ->
    color = hexc $(@).css 'background-color'
    $(@).append("<span style='display:none;'>#{color}</span>")
    $(@).find('span').slideDown('fast')
  ).on 'mouseleave', ->
    $(@).find('span').slideUp 'fast', ->
      $(@).remove()

  $('p.lead').hover (->
    $(@).next().slideDown('fast')
  ), ->
    $(@).next().slideUp('fast')
