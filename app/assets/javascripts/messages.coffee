$ ->

  $.ajax
    type: 'GET'
    url:  '/api/messages'
    success: (data, textStatus, jqXHR) ->
      messagesTemplate = HandlebarsTemplates['messages/index'](data)
      $('#search_message').html(messagesTemplate)

  $('#search_message').on 'click', '.messages-item', (e) ->
    id = $(@).data('id')
    console.log id

    $.ajax
      type: 'GET'
      url:  '/api/messages/' + id
      success: (data, textStatus, jqXHR) ->
        messageTemplate = HandlebarsTemplates['messages/message_details'](data)
        $('#toolModal').html("")
        $('#toolModal').append(messageTemplate)
        $('#toolModal').foundation('reveal').foundation('reveal','open');