class RolesController < ApplicationController
	
  def destroy
		@role = Role.find(params[:id])
    user = @role.user
    @course = @role.course

    email = user ? user.email : "unknown user"
    role = @role ? @role.name : "unknown role"
    course_title = @course ? @course.title : "unknown title"

		if @role.destroy
		  flash[:notice] = "Successfully removed " + user.email + " \(" + @role.name + "\) from \"" + @course.title
    else
      flash[:alert] = "Failed to remove " + email + " \(" + role + "\) from \"" + course_title
    end
    redirect_to edit_course_url(@course)
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
      redirect_to edit_course_url(@course)
    else
      flash[:alert] = "Failed to add a new " + role_name + ".  Please specify a user to give that role to."
      redirect_to request.referer
    end
  end

  def create_many_roles
    @course = Course.find(params[:course_id])
    role_name = params[:role_name] || "Learner"
    # currently we expect all of these identifiers to be email addresses.
    user_identifiers =  ActiveSupport::JSON.decode(params[:users_info])
    rbuilder = RoleBuilder.new(@course, role_name, user_identifiers, current_user.email)
    rbuilder.save!
    
    flash[:notice] = "#{icon("close", "white")}Successfully added user(s): <br> #{rbuilder.successes.join("<br>")} <br>to the #{@course.title} course as #{role_name.pluralize}" unless rbuilder.successes.empty?
    
    flash[:alert] = "#{icon("close", "white")}Failed to add user: <br> #{rbuilder.failures.join("<br>")} <br>in the #{@course.title} course." unless rbuilder.failures.empty?
    
    redirect_to edit_course_url(@course)
  end
end