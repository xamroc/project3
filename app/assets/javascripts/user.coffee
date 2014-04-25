$ ->
  # hit /api/me
  # if a user comes back, render user template
  # if error (401 unauthorized) render not-logged-in template
  $('#header-profile').on 'click', (e) ->
    id = $(@).data('id')
    $.ajax
      type: 'GET'
      url: '/api/users/' + id
      success: (data, textStatus, jqXHR) ->
        userToolsTemplate = HandlebarsTemplates['tools/user_toollist'](data)
        $('#main').html("")
        $('#main').append(userToolsTemplate)
        $('#main').foundation()

  $('#main').on 'change', '.onoffswitch-checkbox', (e) ->
    id = this.dataset.id
    checked = this.checked;
    $.ajax
      type: 'patch'
      url: '/api/tools/' + id
      data: { "tool[availability]": checked }
      success: (data, textStatus, jqXHR) ->
        console.log textStatus

  $('#main').on 'click', '.edit-tool-item', (e) ->
    e.preventDefault()
    id = this.dataset.id
    $.ajax
      type: 'get'
      url: '/api/tools/' + id
      success: (data, textStatus, jqXHR) ->
        newTemplate = HandlebarsTemplates['tools/tool_edit'](data)
        $('#toolModal').html("")
        $('#toolModal').append(newTemplate)
        $('#toolModal').foundation('reveal').foundation('reveal','open');

  id = $('#ajax_user').data('id')
  if id
    $.ajax
      type: 'GET'
      url:  '/api/users/' + id
      data: { _method: "put" }
      success: (data, textStatus, jqXHR) ->
        # if user is logged in...
        $('#ajax_user').html(
          'Email: ' + data.email + 'First Name: ' + data.first_name + 'City: ' + data.city + 'Country: ' + data.country + 'Mobile: ' + data.mobile)
        # otherwise...
  else
    $.ajax
      type: 'GET'
      url:  '/api/users/'
      success: (data, textStatus, jqXHR) ->
        for user in data.users
          $('#ajax_user').append('Name: ' + user.name + 'City: ' + user.city + 'Country: ' + user.country)

