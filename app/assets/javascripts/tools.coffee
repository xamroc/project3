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
        userProfileTemplate = HandlebarsTemplates['users/profile_details'](data)
        toolListTemplate = HandlebarsTemplates['tools/tool_list'](data)

        $('#main').html("")
        $('#main').append(tabTemplate)

        $('#panel-profile').html("")
        $('#panel-profile').append(userProfileTemplate)

        $('#panel-tools').html("")
        $('#panel-tools').append(toolListTemplate)

        $('#main').foundation()

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
    user_id = this.dataset.user_id
    $.ajax
      type: 'get'
      url: '/api/tools/' + id
      success: (data, textStatus, jqXHR) ->
        newTemplate = HandlebarsTemplates['tools/tool_edit'](data)
        $('#toolModal').html("")
        $('#toolModal').append(newTemplate)
        $('#toolModal').foundation('reveal').foundation('reveal','open');
        loadTabs(user_id)

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

  $('#toolModal').on 'submit', '#edittool-form', (e) ->
    $('#toolModal').html("")
    $('#toolModal').append("You have successfully edited your tool.")

  $('#tlist').on 'click', (e) ->
    $.ajax
      type: 'GET'
      url:  '/api/users/'
      success: (data, textStatus, jqXHR) ->
        console.log data
        toolsList = HandlebarsTemplates['users/index'](data)
        $('#tlist').append(toolsList)