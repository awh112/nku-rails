class AttendancesController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    @attendance = Attendance.new
  end
  
  def create
    @current = current_user
    
    @attendance = Attendance.new
    @attendance.seat = params[:attendance][:seat]
    @attendance.attended_on = Time.zone.today
    @attendance.student_id = @current.id
    
    @existing_attendance = Attendance.where(:attended_on => Date.today,
      :student_id => @current.id)
    
    if(@existing_attendance.first == nil)
      @attendance.save
      redirect_to attendances_path, :notice => "You have successfully logged your attendance."
    else
      flash[:error] = "You have already created an attendance for today."
      render "new"
    end
    
    
  end
  
  def show
    @attendances = Attendance.where("student_id = ?", params[:id])
  end
  
  def index
    if(params[:id] == nil)
      @attendances = Attendance.all
    else
      @attendances = Attendance.find(params[:id])
    end      
  end
end
