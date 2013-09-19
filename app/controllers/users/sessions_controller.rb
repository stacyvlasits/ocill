class Users::SessionsController < Devise::SessionsController
	cache_sweeper :navigation_sweeper, :only => [:create]    
end