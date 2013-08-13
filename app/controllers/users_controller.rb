class UsersController < ApplicationController
  respond_to :json, :html

  def show
  	@user = User.find(params[:id])
  	binding.pry
  	@user.attempts.each {|attempt| attempt.destroy if attempt.responses.empty? }
  	respond_with @user
  end

  def index
  	@users = Users.all
  	respond_with @users
  end
end
