# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.timeouts = []

title = (path) ->
  path = path.replace /\\/g, '/'
  path = path.split '/'
  path = path[path.length - 1]
  path = path.replace /\.[\w]+$/g, ''

window.update_version_progress = (video_id, version_id) ->
  element = $('#video-version-' + version_id)
  $.ajax
    url: '/videos/' + video_id + '/version/' + version_id + '/progress.json'
    type: 'get'
    dataType: 'json'
    success: (data, status) ->
      progress = data.progress
      $('.percent', element).html(progress)
      unless progress < 100
        window.clearTimeout(window.timeouts[version_id])
        window.timeouts[version_id] = null
        element.removeClass('version-processing').addClass('version-processed')
  window.timeouts[version_id] = window.setTimeout("window.update_version_progress('"+video_id+"','"+version_id+"')", 5000)

$(document).ready ->
  $('#video_file').change ->
    path = this.value
    $('#video_title').val(title(path))

  $('.version-processing').each (index, element) ->
    video_id = $(element).data('video-id')
    version_id = $(element).data('version-id')
    update_version_progress(video_id, version_id)