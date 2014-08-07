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
  #TODO add errorchecking for empty #drill_title
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
  $(".resize-on-change").keyup(resizeInput).each(resizeInput);

jQuery ->
  $("form").on 'submit', (event, ui) ->
    reSort($(this))

reSort = (object) ->
  object.find('.hidden-position').each (index, element) ->
    $(element).val(index + 1)

resizeInput = () ->
    $(this).attr('size', $(this).val().length);

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').parent().hide()
    event.preventDefault()

# make sure there is a value for the prompt
# remove MS word special characters
jQuery ->
  $('form.fill-drill').on 'submit', (event, ui) ->
    blanks = false
    $('.fill-in-the-blank-field').each (index, element) ->
      if ($(this).val() == "")
        $(this).closest('.control-group').addClass("error")
        blanks = true
        toastr.error("Fill In The Blank fields cannot be left empty.")
      else
        $(this).val(replaceWordChars($(this).val())) 
    event.preventDefault() if blanks 
    return false if blanks 

# clear the error message for empty fill in the blank
jQuery ->
  $('form.fill-drill .fill-in-the-blank-field').on 'focus', (event, ui) ->
    $(this).closest('.control-group').removeClass("error")

jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    current_position = $(this).data('id')
    if (typeof window.position == 'undefined')
      window.position = current_position + 1
    else
      window.position = window.position + 1
    replacement = "([_\\[])" + $(this).data('id') + "([_\\]])"
    regexp = new RegExp(replacement, 'g')
    $(this).before($(this).data('fields').replace(regexp, "$1" + window.position + "$2"))
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

jQuery ->
  $('form').on 'click', '.add-audio-field', (event) ->
    $(this).parent().find('.audio-upload-field').toggleClass('hidden');
    event.preventDefault()

jQuery ->
  $('form').on 'click', '.add-image-field', (event) ->
    $(this).parent().find('.image-upload-field').toggleClass('hidden');
    event.preventDefault()

jQuery ->
  $('.video-player').each (index, element) ->
    source = $(this).text()
    $(this).text('')
    id = "video-" + index
    $(this).attr('id', id)

jQuery ->
  $("form table audio").on 'ended', (event) ->
    playCounter = $(this).closest('td').addClass('finished-playing').find('.audio-played')
    playCounter.val(1)

replaceWordChars = (text) ->
    s = text
    # smart single quotes and apostrophe
    s = s.replace(/[\u2018|\u2019|\u201A]/g, "\'")
    # smart double quotes
    s = s.replace(/[\u201C|\u201D|\u201E]/g, "\"")
    # ellipsis
    s = s.replace(/\u2026/g, "...")
    # dashes
    s = s.replace(/[\u2013|\u2014]/g, "-")
    # circumflex
    s = s.replace(/\u02C6/g, "^")
    # open angle bracket
    s = s.replace(/\u2039/g, "<")
    # close angle bracket
    s = s.replace(/\u203A/g, ">")
    # spaces
    s = s.replace(/[\u02DC|\u00A0]/g, " ")
