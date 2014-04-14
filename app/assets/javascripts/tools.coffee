$ ->
  $.ajax
    type: 'GET'
    url:  '/api/tools'
    success: (data, textStatus, jqXHR) ->

      for element in data.tools
        $('#ajax_tools').append '<span>' + element.name + '</span>'
        if element.availability
          $('#ajax_tools').append '<p> true </p>'
        else
          $('#ajax_tools').append '<p> false </p>'