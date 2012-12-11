# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

#  headers = $("form .separate_fields").first().val()
#  $("form .separate_fields").each (i) ->
#    @value = headers.slice(1, -1).split(", ")[i]
#
#  $("form .separate_fields").change ->
#    col_n = []
#    $("form .separate_fields").each (i) ->
#      col_n.push @value
#
#    $("form #submit-column-names").val col_n

