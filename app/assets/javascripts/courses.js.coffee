# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.add-user-role select').on 'change', (event) ->
    new_user_id = $(this).val()
    cur_href = $(this).next().attr('href')
    replacement = "$1" + new_user_id # javascript regex trick
    new_href = cur_href.replace(/(user_id=)([^&|\n|\r]*)/, replacement)
    $(this).next().attr('href', new_href)


