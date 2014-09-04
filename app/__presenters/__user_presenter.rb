class __UserPresenter < BasePresenter
  presents :user
  
  def email
    h.content_tag :h3, user.email
  end


  def report_full
    user.courses do |course|
    #  full_report_title
      report_course(course)
    end
  end

  def report_course(course)
   # course_header
    user.drills.uniq do |drill|
      h.content_tag :tr, report_drill(drill)
    end
  end

  def report_drill(drill)
    h.content_tag :td, (link_to drill.title.to_s, drill_url(drill))

    drill.attempts do |attempt|
      h.content_tag :td, report_attempt(attempt)
    end
  end

  def report_attempt(attempt)
    h.link_to attempt.score, drill_attempt_url(attempt)
  end


end