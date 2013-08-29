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
  $("#sortable").on 'sortdeactivate', ( event, ui) ->
    $('#sortable .hidden-position').each (index, element) ->
      $(element).val(index + 1)

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

isWav = (jelement) ->
  jelement.data('mime-type') == "audio/wav"

jQuery ->
  $('.audio-player').each (index, element) ->
    if isWav($(this))
      watchInHTML5($(this)) 
    else
      watchInJwplayer($(this))

extractFilename = (url) ->
  url_pieces = url.split("/")
  file_name = url_pieces[url_pieces.length - 1]
  file_name_pieces = file_name.split(".")
  extensionless_file_name = file_name_pieces[file_name_pieces.length - 2]

jQuery ->
  $('.video-player').each (index, element) ->
    source = $(this).text()
    $(this).text('')
    id = extractFilename(source)
    $(this).attr('id', id)
    alert(id + " source: " + source)
    jwplayer(id).setup({flashplayer: "/assets/jwplayer.flash.swf", html5player: "/assets/javascripts/jwplayer.html5.js", file: source, height: 360, width: 640, analytics: { enabled: false, cookies: false }})

watchInHTML5 = (jelement) ->
  audio = jelement.prev()
  jelement.remove()
  audio.on 'ended', (event) ->
    playCounter = audio.parent('td').addClass('finished-playing').find('.audio-played')
    playCounter.val(1)

watchInJwplayer = (jelement) ->
  jelement.prev('audio').remove()
  td = jelement.closest('td')
  td.prepend("<p class=\"waiting-message\">Waiting for audio to load...</p>")
  source = jelement.data('url')
  filename = jelement.attr('id')
  jwplayer(filename).setup({flashplayer: "/assets/jwplayer.flash.swf", html5player: "/assets/javascripts/jwplayer.html5.js", file: source, height: 30, width: 200, analytics: { enabled: false, cookies: false }})
  jwplayer(filename).onReady (event) ->
    td.find('.waiting-message').remove()
  jwplayer(filename).onComplete (event) ->
    playCounter = td.addClass('finished-playing').find('.audio-played')
    playCounter.val(1)
 
