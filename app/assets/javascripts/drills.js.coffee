# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#  When a user sets the drill type on a new drill
#  the form is submitted

# jQuery ->
#  $("#submit-attempt").on 'click', ( event ) ->
#    input_values = $("input.the_blank").map( ->
#     return $(this).val() ).get()
#    joined_values = input_values.join("&&&")
#     $('#attempt_responses').val(joined_values)


jQuery ->
  $("select#drill_type").change ->
    $("form#new_drill :submit").attr("disabled", true)
    $("form#new_drill").submit()

# validate a new drill before creating it
jQuery ->
  $('form#new_drill :submit').click ->
    if ($('#drill_title').val() == "")
      toastr.warning("You must give the drill a title before you create it.")
      event.preventDefault()
    if ($('#drill_type').val() =="DragDrill")
      toastr.warning("This drill type is suitable for Beta Testing ONLY.  Do not attempt to use it with students until this message no longer appears when you select it.  For more information about Beta Testing this feature, please click the <a href='https://devtools.la.utexas.edu/confluence/display/op/Getting+Started+With+OCILL'>Ocill Support</a> button.")


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
  $('form').on 'click', '.add-fields', (event) ->
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

jQuery ->
  $('form').on 'click', '.add-exercise-remote', (event) ->
    # create new exercise
    $.ajax({
      type: "POST",
      dataType: "json",
      data: { "drill_id": $(this).data('drill_id'), "prompt": "prompt"},
      url: '/exercises/',
      success: (my_html) ->
        the_row.after(my_html);
        the_row.siblings('table').wrap('<tr ><td colspan="6"></td></td>');
        expand_button.addClass('hidden');
        hide_button.removeClass('hidden');
      },
        error:  (jqXHR, textStatus, errorThrown)->
        switch (jqXHR.status)
          when "401"
            toastr.error('You must be logged in to update interview information.  <br /> Click <a href="/staff/login?ref=offlineform" alt="Log in">here to login</a>', "error");
          when "500"
            toastr.error('An error prevented your interview information from being updated.', "error");
          else
            toastr.error('An error prevented your interview information from being updated.', "error"))

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
  $('form').on 'change', '.audio-upload-field', (event) ->
    label = $(this).parent().find('.audio-upload-label')
    if ( $(this).val() != "" )
      url = $(this).val()
      label.text(url.substring(url.lastIndexOf("\\") + 1);)
      label.removeClass("hidden")
    else
      label.text("")
      label.addClass("hidden")

jQuery ->
  $('form').on 'click', '.add-audio-field', (event) ->
    # $(this).css('color', 'yellow')
    $(this).parent().find('.audio-upload-field').click()
    $(this).parent().find('.audio-upload-field').toggleClass('hidden');
    event.preventDefault()

jQuery ->
  $('form').on 'click', '.add-image-field', (event) ->
    $(this).parent().find('.image-upload-field').click();
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

displaySpeed = (icon, speed) ->
  console.log("display speed attempted")
  console.log( icon )
  console.log(speed)
  $(icon).siblings('.playback-speed').text(speed.toFixed(2))

jQuery ->
  $(".audio-accelerate").each (index, element) ->
    $(this).on 'click', (event) ->
      icon = $(this)
      audio = icon.siblings('audio')[0]
      console.log(audio)
      if audio.playbackRate < 3
        console.log("Accelerate attempted")
        audio.playbackRate = audio.playbackRate + .25
        console.log("playback rate= " + audio.playbackRate)
      else
        icon.css("color", "red")
        callback = -> icon.css("color", "white")
        setTimeout callback, 1500
      displaySpeed(icon, audio.playbackRate)

jQuery ->
  $(".audio-decelerate").each (index, element) ->
    $(this).on 'click', (event) ->
      icon = $(this)
      audio = icon.siblings('audio')[0]
      console.log(audio)
      if audio.playbackRate > .5
        console.log("Deccelerate attempted")
        audio.playbackRate = audio.playbackRate - .25
        console.log("playback rate= " + audio.playbackRate)
      else
        icon.css("color", "red")
        callback = -> icon.css("color", "white")
        setTimeout callback, 1500
      displaySpeed(icon, audio.playbackRate)

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
