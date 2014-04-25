$ ->
    $('#message-li').on 'click', '.message-li', (e) ->
    id = $(@).data('id')
    console.log id
    # $.ajax
    #   type: 'GET'
    #   url:  '/api/tools/' + id
    #   success: (data, textStatus, jqXHR) ->
    #     newTemplate = HandlebarsTemplates['tools/tool_details'](data)
    #     $('#toolModal').html("")
    #     $('#toolModal').append(newTemplate)
    #     $('#toolModal').foundation('reveal').foundation('reveal','open');