class StudentsController < ApplicationController
  def index
  end
  
  def new
  end
  
  def create
    @student = Student.new(student_params)
    @student.save
    redirect_to @student
  end
  
  def show
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
      flash[:success] = "You have successfully edited your account."
      redirect_to students_path
    else
      render 'edit'
    end
  end
  
  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image)
  end
end
