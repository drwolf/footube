# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

title = (path) ->
  path = path.replace /\\/g, '/'
  path = path.split '/'
  path = path[path.length - 1]
  path = path.replace /\.[\w]+$/g, ''

$(document).ready ->
  $('#video_file').change ->
    path = this.value
    $('#video_title').val(title(path))
