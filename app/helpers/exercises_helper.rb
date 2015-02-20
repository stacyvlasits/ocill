module ExercisesHelper
  def graded_fill_drill_exercise(exercise, responses)
    spans = exercise.exercise_items.map do |ei|
      # TODO reduce number of sql queries
      if response = responses.where(:exercise_item_id => ei).first
        '<span class="' + graded_class(response) + '">'  + response.value.to_s + '</span>' + " " + (response.correct? ? icon("ok") : icon("times")) 
      else
        '<span class="left-blank"></span>' + icon("times")
      end
    end
    html = exercise.prompt_with_hints.gsub(/\[/,'{{').gsub(/\]/,'}}')
    spans.each {|span| html.sub!(/\{\{.+?\}\}/, span) }
    html
  end

  def graded_drag_drill_exercise(exercise, responses)

  end

  def graded_class(response)
    graded_class = "incorrect"
    graded_class = "correct" if response.correct? 
    graded_class = "left-blank" if response.value.blank?
    graded_class
  end

  def graded_grid_drill_exercise(exercise, responses)
    html = ""
    exercise.exercise_items.each do |ei|
      if ei.answers
        response = responses.where(:exercise_item_id => ei).first
        html += "<td>" + (response.correct? ? icon("ok") : icon("times")) + "</td>"
      else
        html += "<td>--</td>".html_safe
      end
    end
    html.html_safe
  end

  def edit_fill_drill_exercise(exercise, responses)
    inputs = exercise.exercise_items.map do |ei|
      response = responses.where(:exercise_item_id => ei)
      create_response_input(ei.id, response.first.id)
    end
    prompt = exercise.prompt_with_hints.gsub(/\[/,'{{').gsub(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def attempt_drag_drill_exercise(exercise,responses )
    
    inputs = exercise.exercise_items.map do |ei|
      if response = responses.select {|r| r.exercise_item_id == ei.id}.first
        create_response_input(ei.id, response.id, "text", "correct", response.value)
      end
    end
    "<h1>Hi!</h1>"
  end

  def attempt_fill_drill_exercise(exercise, responses)
    inputs = exercise.exercise_items.map do |ei|
      if response = responses.select {|r| r.exercise_item_id == ei.id}.first
        create_response_input(ei.id, response.id, "text", "correct", response.value)
      else
        response = Response.create(exercise_item_id:ei.id, attempt_id: @attempt.id, value:'')
        create_response_input(ei.id, response.id)
      end
    end
    prompt = exercise.prompt_with_hints.gsub(/\[/,'{{').gsub(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def create_response_input(exercise_item_id, response_id, type="text", css_class="the_blank", value="" )
    '<input id="attempt_responses_attributes_' + response_id.to_s + '_exercise_item_id" name="attempt[responses_attributes][' + response_id.to_s + '][exercise_item_id]" type="hidden" value="' + exercise_item_id.to_s + ' "/><input class="' + css_class + '" id="attempt_responses_attributes_' + response_id.to_s + '_value" name="attempt[responses_attributes][' + response_id.to_s + '][value]" type="' + type + '" value="' + value + '"/>'
  end

  def create_grid_drill_exercises(exercise, responses)

    inputs = exercise.exercise_items.map do |ei|
      if response = responses.select {|r| r.exercise_item_id == ei.id}.first
        input = "<td class=\"finished-playing\">"
        input += create_response_input(ei.id, response.id, "hidden", "audio-played", response.value)
      else
        input= "<td>"
        response = Response.create(exercise_item_id:ei.id)
        input += create_response_input(ei.id, response.id, "hidden", "audio-played", "0" )
      end
        input += audio_tag(ei.audio_urls) unless ei.audio_url.blank? || ei.audio_url.include?("fallback")
        input += image_tag(exercise.image_url(:small)) unless exercise.image.blank? || exercise.image_url.include?("fallback")
        text = ei.text unless exercise.drill.hide_text?
        input += content_tag(:p, text )
        input += "</td>"
    end
    inputs.join('')
  end

end



