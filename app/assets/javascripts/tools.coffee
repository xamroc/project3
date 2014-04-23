$ ->
  $.ajax
    type: 'GET'
    url:  '/api/tools'
    success: (data, textStatus, jqXHR) ->
      for element in data.tools
      #   console.log element
        $('#ajax_tools').append "<li>" + element.name + "</li>"