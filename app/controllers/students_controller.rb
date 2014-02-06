class StudentsController < ApplicationController  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params)
    
    require 'digest/md5'
    email_address = @student.email.downcase    
    hash = Digest::MD5.hexdigest(email_address)
    
    @student.image = 'http://www.gravatar.com/avatar/' + hash    
    @student.save
    
    if @student.save
      redirect_to students_path, :notice => "You have successfully signed up."
    else
      render "new"
    end
  end
  
  def show
    @current = current_user
    flash[:info] = @current.name
    
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
    
    if @student.update(params[:student].permit(:name, :nickname, :email, :image))
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
    
    redirect_to students_path
  end
  
  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image, :password, :password_confirmation)
  end
end
