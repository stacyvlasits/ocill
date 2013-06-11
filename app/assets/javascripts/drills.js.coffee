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

# reveal the tiny mce Toolbar
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
    $(this).before($(this).data('fields').replace(regexp, window.position))
    fixRTL()
    event.preventDefault()

# Handles RTL
jQuery ->
  fixRTL()
  $('form').on 'change', '.set-rtl', (event) ->
    fixRTL()
    event.preventDefault()

fixRTL = () ->
  $('form .text-field').addClass('rtl') if $('.set-rtl').is(':checked')
  $('form .text-field').removeClass('rtl') unless $('.set-rtl').is(':checked')

hideUpload = () ->
  $('form .upload-field').addClass('hidden')

jQuery ->
  $('form').on 'click', '.add-audio-field', (event) ->
    hideUpload()
    $(this).parent().find('.audio-upload-field').toggleClass('hidden');
    event.preventDefault()

jQuery ->
  $('form').on 'click', '.add-image-field', (event) ->
    hideUpload()
    $(this).parent().find('.image-upload-field').toggleClass('hidden');
    event.preventDefault()

jQuery ->
  $('form audio').bind 'ended', (event) ->
    playCounter = $(this).parent().find('.audio-played')
    playCounter.parent().css('background-color', 'lightgreen')
    playCounter.val(1)
    
