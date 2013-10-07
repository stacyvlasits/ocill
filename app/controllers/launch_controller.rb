class LaunchController < ApplicationController
	skip_before_filter :authenticate_user!
  def create
  	@params = params
  	
  end
end
