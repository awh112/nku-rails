class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
  end
  
  def create
    @current = current_user
    
    @attendance = Attendance.new
    @attendance.seat = params[:attendance][:seat]
    @attendance.attended_on = Date.today
    @attendance.student_id = @current.id
    
    @existingAttendance = Attendance.find_by_attended_on(Date.today)
    
    if(@existingAttendance == nil)
      @attendance.save
      redirect_to attendances_path, :notice => "You have successfully logged your attendance."
    else
      flash[:error] = "You have already created an attendance for today."
      render "new"
    end
    
    
  end
  
  def show
    @attendance = Attendance.find(params[:id])
  end
  
  def index
    @attendances = Attendance.all
  end
end
