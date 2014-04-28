$ ->
  # hit /api/me
  # if a user comes back, render user template
  # if error (401 unauthorized) render not-logged-in template

  $('#main').on 'change', '.onoffswitch-checkbox', (e) ->
    id = this.dataset.id
    checked = this.checked;
    $.ajax
      type: 'patch'
      url: '/api/tools/' + id
      data: { "tool[availability]": checked }
      success: (data, textStatus, jqXHR) ->
        console.log textStatus

  # $('#main').on 'click', '#edit_user_button', (e) ->
  #   e.preventDefault()
  #   id = this.dataset.userid
  #   $.ajax
  #     type: 'get'
  #     url: '/api/users/' + id
  #     success: (data, textStatus, jqXHR) ->
  #       userEditTemplate = HandlebarsTemplates['users/user_edit'](data)
  #       console.log userEditTemplate
  #   #     $('#toolModal').html("")
  #   #     $('#toolModal').append(newTemplate)
  #   #     $('#toolModal').foundation('reveal').foundation('reveal','open');


    # TODO access form for current user


  $('#main').on 'click', '.field', (e) ->
    field_item = $(@)
    if field_item.find(".temp-input").is("input")
      console.log 'yay!'
    else
      console.log field_item.prop "tagName"
      console.log field_item
      attribute = field_item.data().field
      userId = field_item.data().userId
      value = field_item.html()
      field_item.html(
        $("<form id=\"field-form\"><input class=\"temp-input\" type=\"text\" name=\"user[#{attribute}]\" value=\"#{value}\"></form>")
      )
      $('.temp-input').focus()

  $('#main').on 'submit', '#field-form', (e) ->
    input = $(".temp-input")
    value = input.val()
    parent = $(@).parent()
    userId = parent.data().userid
    field_name = parent.data().field
    obj = {}
    obj[field_name] = value
    parent.html(value)
    $.ajax "/api/users/#{userId}",
      method: 'PATCH'
      contentType: 'application/json'
      dataType: 'json'
      data: JSON.stringify( {user:obj})
      success: (data) =>
        parent.html(value)
    e.preventDefault()

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

