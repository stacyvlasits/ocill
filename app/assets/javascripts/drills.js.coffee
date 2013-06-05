# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#  When a user sets the drill type on a new drill
#  the form is submitted

# jQuery ->
#  $("#attempt-submit").on 'click', ( event ) ->
#    input_values = $("input.the_blank").map( ->
#     return $(this).val() ).get()
#    joined_values = input_values.join("&&&")
#     $('#attempt_responses').val(joined_values)

jQuery ->
  $("select#drill_type").on 'change', ( event ) ->
    $("form#new_drill").submit()

jQuery ->
  $(".mceLayout").focus ->
    $(this).toggleClass('mceHideToolbar')

jQuery ->
  $("#sortable").sortable({
    forcePlaceholderSize: true,
    placeholder: "ui-state-highlight"
  });

jQuery ->
  $("#sortable").on 'sortchange', ( event, ui) ->
    $("#sortable li .hidden-position").each (index, element) ->
      $(element).val(index)

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').parent().hide()
    event.preventDefault()

jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    current_position = $(this).data('id')
    if (typeof window.position == 'undefined')
      window.position = current_position + 1
    else
      window.position = window.position + 1
    regexp = new RegExp($(this).data('id'), 'g')
    $('.add_fields').before($('.add_fields').data('fields').replace(regexp, window.position))
    event.preventDefault()

jQuery ->
  $('.text-field').addClass('rtl') if $('.set-rtl').is(':checked')
  $('.text-field').removeClass('rtl') unless $('.set-rtl').is(':checked')
  $('form').on 'change', '.set-rtl', (event) ->
    $('.text-field').toggleClass('rtl')
    regexp = /class="/g
    rtl_fields = $('.add_fields').data('fields').replace(regexp,'class="rtl ')
    $('.add_fields').attr('data-fields', "rtl_fields")
    event.preventDefault()

jQuery ->
  $('form').on 'click', '.open-upload-form', (event) ->
    cell = $(this).parent().find('.audio-upload-form').toggleClass('hidden');
    event.preventDefault()
