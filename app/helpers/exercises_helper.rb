module ExercisesHelper
  def graded_fill_drill_exercise(exercise, responses)
    spans = exercise.exercise_items.map do |ei|
      # TODO reduce number of sql queries
      if response = responses.find {|r| r.exercise_item_id.to_i == ei.id }
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
        response = responses.find {|r| r.exercise_item_id.to_i == ei.id }
        html += "<td>" + (response.correct? ? icon("ok") : icon("times")) + "</td>"
      else
        html += "<td>--</td>".html_safe
      end
    end
    html.html_safe
  end

  def edit_fill_drill_exercise(exercise, responses, attempt_id)
    inputs = exercise.exercise_items.map do |ei|
      create_response_input(ei.id, attempt_id)
    end
    prompt = exercise.prompt_with_hints.gsub(/\[/,'{{').gsub(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

#TODO  FINISH THIS OR DELETE IT
  def attempt_drag_drill_exercise(exercise, responses, attempt_id )

    inputs = exercise.exercise_items.map do |ei|
      if response = responses.find {|r| r.exercise_item_id.to_i == ei.id }
        create_response_input(ei.id, attempt_id, "text", "correct", response.value)
      end
    end
  end

  def attempt_fill_drill_exercise(exercise, responses, attempt_id)
    inputs = exercise.exercise_items.map do |ei|
      if response = responses.find {|r| r.exercise_item_id.to_i == ei.id }
        create_response_input(ei.id, attempt_id, "text", "correct", response.value)
      else
        response = Response.new( {exercise_item_id:ei.id, attempt_id: @attempt.id, value:''} )
        @attempt.responses += [response]
        create_response_input(ei.id, attempt_id)
      end
    end
    prompt = exercise.prompt_with_hints.gsub(/\[/,'{{').gsub(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def create_response_input(exercise_item_id, attempt_id, type="text", css_class="the_blank", value="" )
    i = rand(1...999999999)
    '
      <input id="attempt_responses_exercise_item_id" name="attempt[responses][' + i.to_s + '][exercise_item_id]" type="hidden" value="' + exercise_item_id.to_s + ' "/>

      <input class="' + css_class + '" id="attempt_responses_value" name="attempt[responses][' + i.to_s + '][value]" type="' + type + '" value="' + value + '"/>
    '
  end

  def create_grid_drill_exercises(exercise, responses)

    inputs = exercise.exercise_items.map do |ei|
      if response = responses.select {|r| r.exercise_item_id == ei.id}.first
        input = "<td class=\"finished-playing\">"
        input += create_response_input(ei.id, response.id, "hidden", "audio-played", response.value)
      else
        input= "<td>"
        response = Response.new({"exercise_item_id" => ei.id})
        input += create_response_input(ei.id, 80085, "hidden", "audio-played", "0" )
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
