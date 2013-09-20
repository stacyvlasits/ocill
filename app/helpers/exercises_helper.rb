module ExercisesHelper
  # TODO  Why is this not being used?
  def attempt_fill_drill_exercises(exercise)
    initial_prompt = exercise.prompt
    hint = '<span class="hint">' + initial_prompt[/\(.+?\)/] + '</span>'
    hintless_prompt = initial_prompt.gsub(/\(.+?\)/, '')
    pre_prompt = '<span class="prompt-section">'
    final_prompt = hintless_prompt.gsub(/\[.+?\]/, '</span><input class="the_blank" /><span class="prompt-section">')
    post_prompt = '</span>'
    pre_prompt + final_prompt + post_prompt + hint
  end

  def graded_fill_drill_exercise(exercise, responses)
    spans = exercise.exercise_items.map do |ei|
      # TODO reduce number of sql queries
      if response = responses.where(:exercise_item_id => ei).first
        '<span class="' + (response.correct? ? "correct" : "incorrect") + '">'  + response.value.to_s + '</span>' + " " + (response.correct? ? icon("ok") : icon("remove")) 
      else
        '<span class="incorrect"></span>' + icon("remove")
      end
    end
    html = exercise.hintless_prompt.gsub(/\[/,'{{').gsub(/\]/,'}}')
    spans.each {|span| html.sub!(/\{\{.+?\}\}/, span) }
    html
  end

  def graded_grid_drill_exercise(exercise, responses)
    html = ""
    exercise.exercise_items.each do |ei|
      if ei.answers
        response = responses.where(:exercise_item_id => ei).first
        html += "<td>" + (response.correct? ? icon("ok") : icon("remove")) + "</td>"
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
    prompt = exercise.hintless_prompt.gsub(/\[/,'{{').gsub(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def create_fill_drill_exercise(exercise)
    inputs = exercise.exercise_items.map do |ei|
      response = Response.create(exercise_item_id:ei.id)
      create_response_input(ei.id, response.id)
    end
    prompt = exercise.hintless_prompt.gsub(/\[/,'{{').gsub(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def create_response_input(exercise_item_id, response_id, type="text", css_class="the_blank", value="" )
    '<input id="attempt_responses_attributes_' + response_id.to_s + '_exercise_item_id" name="attempt[responses_attributes][' + response_id.to_s + '][exercise_item_id]" type="hidden" value="' + exercise_item_id.to_s + ' "/><input class="' + css_class + '" id="attempt_responses_attributes_' + response_id.to_s + '_value" name="attempt[responses_attributes][' + response_id.to_s + '][value]" type="' + type + '" value="' + value + '"/>'
  end

  def create_grid_drill_exercises(exercise)
    hide_text = exercise.drill.hide_text
    inputs = exercise.exercise_items.map do |ei|
      input = "<td>"
      response = Response.create(exercise_item_id:ei.id)
      input += create_response_input(ei.id, response.id, "hidden", "audio-played", "0" )
      input += audio_tag(ei.audio_urls) unless ei.audio_url.blank? || ei.audio_url.include?("fallback")
      input += image_tag(exercise.image_url(:small)) unless exercise.image.blank? || exercise.image_url.include?("fallback")
      text = ei.text unless hide_text
      input += content_tag(:p, text )
      input += "</td>"
    end
    inputs.join('')
  end

end



