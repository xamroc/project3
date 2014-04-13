$ ->
  $('#ajax_tools').on 'click', (e) ->
    $('#ajax_tools').html('')
    $.ajax
      type: 'GET'
      url:  '/api/tools'
      success: (data, textStatus, jqXHR) ->

        for element in data.tools
          $('#ajax_tools').append '<p>' + element.name + '</p>'
          if element.availability
            $('#ajax_tools').append '<p> true </p>'
          else
            $('#ajax_tools').append '<p> false </p>'

      e.preventDefault()