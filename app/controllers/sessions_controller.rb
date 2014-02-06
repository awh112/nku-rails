class SessionsController < ApplicationController
  def new
  end
  
  def create    
    @current = current_user
    flash[:success] = @current.name
    
    student = Student.find_by_email(params[:email])
    if student && student.authenticate(params[:password])
      session[:user_id] = student.id
      redirect_to students_path
    else
      flash[:error] = "Invalid username or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
