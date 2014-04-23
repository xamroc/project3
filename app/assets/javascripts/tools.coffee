$ ->
  $.ajax
    type: 'GET'
    url:  '/api/tools'
    success: (data, textStatus, jqXHR) ->
      for element in data.tools
      #   console.log element
        $('#ajax_tools').append("<div class='tool-item'>" + element.name + "</div>")

  $('#search').keyup () ->

    searchField = $('#search').val()

    $.ajax
      type: 'GET'
      url:  '/api/tools'
      data:
        search: searchField
      success: (data, textStatus, jqXHR) ->

        test = ul = $("<ul>")

        for element in data.tools
          ul.append "<li>" + element.id + "</li>"
          ul.append "<li>" + element.name + "</li>"
          ul.append "<li>" + element.category + "</li>"


        $('#ajax_test').html(ul)
