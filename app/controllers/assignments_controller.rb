class AssignmentsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    @assignment = Assignment.new
  end
  
  def create
    @assignment = Assignment.new
    
    #get the student ID of the student typed in the field, match by name
    @selected_student = Student.find_by_name(params[:student])
    
    @assignment.student = @selected_student
    @assignment.name = params[:assignment][:name]
    @assignment.score = params[:assignment][:score]
    @assignment.total = params[:assignment][:total]
    
    @assignment.save
    redirect_to assignments_path, :notice => "You have successfully created this assignment."
  end
  
  def index    
    @assignments = Assignment.all
  end
  
  def show
    @assignments = Assignments.where("student_id = ?", params[:id])
  end
end
