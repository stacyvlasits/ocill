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
end
