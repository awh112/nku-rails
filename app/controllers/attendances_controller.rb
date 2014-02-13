class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
  end
  
  def create
    @current = current_user
    
    @attendance = Attendance.new
    @attendance.seat = params[:attendance][:seat]
    debugger
    @attendance.attended_on = Time.now
    @attendance.student_id = @current.id
    @attendance.save
    
    if @attendance.save
      redirect_to attendances_path
    else
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
