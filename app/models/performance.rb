class Performance
  attr_reader :drill, :user, :best_attempt, :worst_attempt, :user_attempts

  def initialize(drill, user)
    @drill = drill
    @user = user
    @user_attempts = @user.attempts.where(:drill_id => @drill.id)
    @best_attempt = @user_attempts.max{|a, b| a.correct <=> b.correct}
    @worst_attempt = @user_attempts.min{|a, b| a.correct <=> b.correct}
  end

  def not_by_learner?
  	@user.roles.is_learner(@user).in_course(@drill.course).empty?
  end

  def total_attempts
    @user_attempts.size
  end

  def best_attempt_created_at
    @best_attempt.created_at.to_s(:simple_date)
  end

  def total_score
    @user_attempts.inject(0) {|sum, attempt| sum + attempt.correct}
  end

  def total_responses
    @user_attempts.inject(0) {|sum, attempt| sum + attempt.total}
  end

  def average_score
    attempts = total_attempts
    score = total_score
    if attempts == 0
      "--" # this should never happen
    elsif score == 0
      0.0
    else
      (score.to_f/attempts).round(2)
    end
  end

end
