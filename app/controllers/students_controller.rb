class StudentsController < ApplicationController  
  skip_before_action :require_login, only: [:new, :create, :index]
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params)
    
    require 'digest/md5'
    email_address = @student.email.downcase    
    hash = Digest::MD5.hexdigest(email_address)
    
    if(@student.image == nil)
      @student.image = 'http://www.gravatar.com/avatar/' + hash    
    end
    @student.save
    
    if @student.save
      session[:user_id] = @student.id
      redirect_to students_path, :notice => "You have successfully signed up."
    else
      render "new"
    end
  end
  
  def show
    @current = current_user
    
    @student = Student.find(params[:id])
    
    require 'digest/md5'
    email_address = @student.email.downcase
    
    hash = Digest::MD5.hexdigest(email_address)
    
    @student.image = 'http://www.gravatar.com/avatar/' + hash
    @student.save
  end
  
  def index    
    @students = Student.all
  end
  
  def edit
    @student = Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
    
    if @student.update(params[:student].permit(:name, :nickname, :email, :image, :is_admin))
      if @student.image.empty?        
        require 'digest/md5'
        email_address = @student.email.downcase
      
        hash = Digest::MD5.hexdigest(email_address)
      
        @student.image = 'http://www.gravatar.com/avatar/' + hash
        @student.save
      end      
      flash[:success] = "You have successfully edited " + @student.name
      redirect_to students_path
    else
      flash[:success] = "You have successfully edited " + @student.name
      redirect_to students_path
      render 'edit'
    end
  end
  
  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    
    session[:user_id] = nil
    @current_user = nil
    redirect_to students_path
  end
  
  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image, :password, :password_confirmation)
  end
end
