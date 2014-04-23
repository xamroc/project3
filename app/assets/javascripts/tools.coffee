$ ->
  $.ajax
    type: 'GET'
    url:  '/api/tools'
    success: (data, textStatus, jqXHR) ->
      template = HandlebarsTemplates['tools/index'](data)
      $('#ajax_tools').append(template)

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


        $('#search_result').html(ul)

  $('#ajax_tools').on 'click', '.tool-item', (e) ->
    id = $(@).data('id')
    $.ajax
      type: 'GET'
      url:  '/api/tools/' + id
      success: (data, textStatus, jqXHR) ->
        console.log data
