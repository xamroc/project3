$ ->
  $('#ajax_user').on 'click', (e) ->
    id = $('#ajax_user').data('id')
    $.ajax
      type: 'GET'
      url:  '/api/users/' + id
      success: (data, textStatus, jqXHR) ->
        $('#ajax_user').html(data.email)

      e.preventDefault()