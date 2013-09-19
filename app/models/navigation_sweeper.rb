class NavigationSweeper < ActionController::Caching::Sweeper
  observe Course, Unit, Drill

  def expire_cached_content(record)
    expire_fragment(:fragment => 'main_navigation')
  end

  alias_method :after_save, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
end