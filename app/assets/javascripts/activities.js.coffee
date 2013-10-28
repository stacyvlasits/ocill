# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$("#course-submit").addClass('hidden')

jQuery ->
	$(".selectable-course + label").on 'click', ( event ) ->
		course_id = $(this).prev().val()
		$('#activity_drill_id').val('')
		new_href = $("#course-submit").attr('href').replace(/\/\d+$/, "/" + course_id).replace(/\/undefined/, "/" + course_id)
		$("#course-submit").attr('href', new_href)
		$('.activity-submit').addClass('disabled')
		$('#course-submit').click()
