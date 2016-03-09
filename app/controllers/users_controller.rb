class UsersController < ApplicationController
  load_and_authorize_resource
  respond_to :json, :html

  def show
  	@user = User.find(params[:id])
    # TODO this way of maintaining the integrity of the attempts collection is a little kludgie
  	@user.attempts.each {|attempt| attempt.destroy if attempt.responses.empty? }
  	respond_with @user
  end

  def index
  	@users = User.all
  	respond_with @users
  end

  private
    def users_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :remember_me, :lti_user_id, :id)
    end

end
