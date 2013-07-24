class RolesController < ApplicationController
	
  def destroy
		@role = Role.find(params[:id])
    user = @role.user
    @course = @role.course
		if @role.destroy
		  flash[:notice] = "Successfully removed " + user.email + " \(" + @role.name + "\) from \"" + @course.title
    else
      flash[:alert] = "Failed to remove " + user.email + " \(" + @role.name + "\) from \"" + @course.title
    end
    redirect_to course_path(@course)
	end

  def create
    @course = Course.find(params[:course_id])
    @user = User.find(params[:user_id]) unless params[:user_id] == ""
    role_name = params[:role_name]
    
    if @user
      if @course.roles.create(:user => @user, :name => role_name)
        flash[:notice] = "Successfully added " + @user.email + " to \"" + @course.title + "\" as " + role_name
      else
        flash[:alert] = "Failed to add " + @user.email + " to Course: " + @course.title + " as a " + role_name
      end
      redirect_to course_path(@course)
    else
      flash[:alert] = "Failed to add a new " + role_name + ".  Please specify a user to give that role to."
      redirect_to request.referer
    end
  end
end