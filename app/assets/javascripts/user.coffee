$ ->
  $('#ajax_user').on 'click', (e) ->
    $.ajax
      type: 'GET'
      url: '/api/users/1'
      success: (data, textStatus, jqXHR) ->
        $('#ajax_user').html(data.email)

      e.preventDefault()