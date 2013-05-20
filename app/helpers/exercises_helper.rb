module ExercisesHelper
# TODO change so that 'perform_fill_drill_exercises(exercise, attempt)'
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
      response = responses.where(:exercise_item_id => ei)
      '<span class="' + (response.first.correct? ? "correct" : "incorrect") + '">' + response.first.value.to_s + '</span>'
    end
    prompt = exercise.hintless_prompt.gsub!(/\[/,'{{').gsub!(/\]/,'}}')
    spans.each {|span| prompt.sub!(/\{\{.+?\}\}/, span) }
    prompt
  end

  def edit_fill_drill_exercise(exercise, responses)
    inputs = exercise.exercise_items.map do |ei|
      response = responses.where(:exercise_item_id => ei)
      create_response_input(ei.id, response.first.id)
    end
    prompt = exercise.hintless_prompt.gsub!(/\[/,'{{').gsub!(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def create_fill_drill_exercise(exercise)
    inputs = exercise.exercise_items.map { |ei| create_response_input(ei.id, rand(10000000000..20000000000)) }
    prompt = exercise.hintless_prompt.gsub!(/\[/,'{{').gsub!(/\]/,'}}')
    inputs.each {|input| prompt.sub!(/\{\{.+?\}\}/, input) }
    prompt
  end

  def create_response_input(exercise_item_id, response_id)
    '<input id="attempt_responses_attributes_' + response_id.to_s + '_exercise_item_id" name="attempt[responses_attributes][' + response_id.to_s + '][exercise_item_id]" type="hidden" value="' + exercise_item_id.to_s + ' "/><input class="the_blank" id="attempt_responses_attributes_' + response_id.to_s + '_value" name="attempt[responses_attributes][' + response_id.to_s + '][value]" type="text" value=""/>'
  end
end



