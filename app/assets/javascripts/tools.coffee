# $ ->
#   $.ajax
#     type: 'GET'
#     url:  '/api/tools'
#     success: (data, textStatus, jqXHR) ->

#       for element in data.tools
#         $('#ajax_tools').append '<span>' + element.name + '</span>'
#         if element.availability
#           $('#ajax_tools').append '<p> true </p>'
#         else
#           $('#ajax_tools').append '<p> false </p>'


#   # TODO: make JSON url based on search input

#   $('#search-button').on "click", (e) ->
#     input = $("#search-input").val()
#     $.ajax
#       type: 'GET'
#       # We NEED a URL!!!
#       url: ''
#       data: input
#       success: (data, textStatus, jqXHR) ->

#         # TODO: render data on view


app = {};

app.Todo = Backbone.Model.extend({
  defaults: {
    title: '',
    completed: false
  }
});