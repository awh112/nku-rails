class AssignmentsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :is_admin, only: [:new]
  
  def new
    @assignment = Assignment.new
  end
  
  def create
    @assignment = Assignment.new
    
    #get the student ID of the student typed in the field, match by name
    @selected_student = Student.find_by_name(params[:student][:student_id])
    
    @assignment.student = @selected_student
    @assignment.name = params[:assignment][:name]
    @assignment.score = params[:assignment][:score]
    @assignment.total = params[:assignment][:total]
    
    @assignment.save
    redirect_to students_path, :notice => "You have successfully created the assignment."
  end
  
  
  def show
    @assignments = Assignment.where("student_id = ?", params[:id])
  end
  
  def index
    if(params[:id] == nil)
      @assignments = Assignment.all
    else
      @assignments = Assignment.where("student_id = ?", params[:id])
    end      
  end  
end
