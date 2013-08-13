# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.add-user-role select').on 'change', (event) ->
    updateLink( $(this), $(this).next(), "user_id" )

jQuery ->
  $('.add-user-batch textarea').on 'blur', (event) ->
    updateLink( $(this), $(this).next(), "users_info" )
    validated = validateEmailsEids( $(this) )
    $(this).parent().find('.proof').html(validated).removeClass("hidden") 

updateLink = (source, link, link_argument) ->
  new_source_text = JSON.stringify(source.val().split('\n'))
  new_source_text = encodeURIComponent(new_source_text)
  cur_href = link.attr('href')
  replacement = "$1" + new_source_text # javascript regex trick
  pattern = '(' + link_argument + '=)([^&|\n|\r]*)'
  re = new RegExp(pattern);
  new_href = cur_href.replace(re, replacement)
  link.attr('href', new_href)

validateEmailsEids = ( textarea ) ->
  text = textarea.val()
  eids_marked = markEids(text)
  emails_and_eids_marked = markEmails(eids_marked)
  return emails_and_eids_marked

markEids = (text) ->
  eid_pattern = '[a-z]+[0-9]+' 
  re = new RegExp(eid_pattern, "g")
  return text.replace(re, '<span class="green">' + " validated eid text " + '</span>' )

markEmails = (text) ->
  email_pattern = '[a-z0-9\+\.]+\@[a-z0-9\+\.]+\.[a-z]{1,5}' # TODO fix this sucky regex 
  re = new RegExp(email_pattern, "g")
  return text.replace(re, '<span class="lightgreen">' + " validated email text " + '</span>' )
