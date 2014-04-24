$ ->
  $.ajax
    type: 'GET'
    url:  '/api/tools'
    success: (data, textStatus, jqXHR) ->
      template = HandlebarsTemplates['tools/index'](data)
      $('#main').append(template)

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

  $('#main').on 'click', '.tool-item', (e) ->
    id = $(@).data('id')
    $.ajax
      type: 'GET'
      url:  '/api/tools/' + id
      success: (data, textStatus, jqXHR) ->
        newTemplate = HandlebarsTemplates['tools/tool_details'](data)
        $('#toolModal').html("")
        $('#toolModal').append(newTemplate)
        $('#toolModal').foundation('reveal').foundation('reveal','open');

  $('#tlist').on 'click', (e) ->
    $.ajax
      type: 'GET'
      url:  '/api/users/'
      success: (data, textStatus, jqXHR) ->
        console.log data
        toolsList = HandlebarsTemplates['users/index'](data)
        $('#tlist').append(toolsList)