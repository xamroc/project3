$ ->
  $.ajax
    type: 'GET'
    url:  '/api/tools'
    success: (data, textStatus, jqXHR) ->
      template = HandlebarsTemplates['tools/index'](data)
      $('#main').append(template)

  $('#header-profile').on 'click', (e) ->
    user_id = $(@).data('id')
    loadTabs(user_id)

  loadTabs = (user_id) ->
    $.ajax
      type: 'GET'
      url: '/api/users/' + user_id
      success: (data, textStatus, jqXHR) ->
        tabTemplate = HandlebarsTemplates['site/tabs']

        $('#main').html("")
        $('#main').append(tabTemplate)

        loadUserProfile(data)
        loadToolsList(data)

        $('#main').foundation()

  loadUserProfile = (data) ->
    userProfileTemplate = HandlebarsTemplates['users/profile_details'](data)
    $('#panel-profile').html("")
    $('#panel-profile').append(userProfileTemplate)

  loadToolsList = (data) ->
    toolListTemplate = HandlebarsTemplates['tools/tool_list'](data)
    $('#panel-tools').html("")
    $('#panel-tools').append(toolListTemplate)

  $('#search').keyup () ->

    searchField = $('#search').val()

    $.ajax
      type: 'GET'
      url:  '/api/tools'
      data:
        search: searchField
      success: (data, textStatus, jqXHR) ->

        searchTemplate = HandlebarsTemplates['tools/search_details'](data)
        $('#search_result').html(searchTemplate)

  $('#search_result').on 'click', '.tool-search-item', (e) ->
    id = $(@).data('id')

    $.ajax
      type: 'GET'
      url:  '/api/tools/' + id
      success: (data, textStatus, jqXHR) ->
        newTemplate = HandlebarsTemplates['tools/tool_details'](data)
        $('#toolModal').html("")
        $('#toolModal').append(newTemplate)
        $('#toolModal').foundation('reveal').foundation('reveal','open');

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

  $('#main').on 'click', '.tool-item', (e) ->
    id = $(@).data('id')
    $.ajax
      type: 'GET'
      url:  '/api/tools/' + id
      success: (data, textStatus, jqXHR) ->
        newTemplate = HandlebarsTemplates['tools/tool_details'](data)
        $('#toolModal').html("")
        $('#toolModal').append(newTemplate)
        $('#toolModal').foundation('reveal').foundation('reveal','open')

  successMessage = () ->
    $('#toolModal').html("")
    $('#toolModal').append("You have successfully edited your tool.")

  toolsListRefresh = (user_id) ->
    $.ajax
      type: 'GET'
      url:  '/api/users/' + user_id
      success: (data, textStatus, jqXHR) ->
        loadToolsList(data)
        $('#toolModal').foundation('reveal','close')

  $('#toolModal').on 'submit', '#edittool-form', (e) ->
    e.preventDefault()

    userId = $(@).data().userid
    tool = $(@).serializeJSON()

    $.ajax "/api/users/#{userId}/tools/#{tool['tool']['id']}",
      type: 'PATCH'
      contentType: 'application/json'
      dataType: 'json'
      data: JSON.stringify(tool)
      success: (data) ->
        successMessage()
        toolsListRefresh(userId)
      error: (x,y,z) ->
        console.log x, y, z

  $('#tlist').on 'click', (e) ->
    $.ajax
      type: 'GET'
      url:  '/api/users/'
      success: (data, textStatus, jqXHR) ->
        console.log data
        toolsList = HandlebarsTemplates['users/index'](data)
        $('#tlist').append(toolsList)