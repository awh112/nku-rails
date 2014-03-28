class UploadsController < ApplicationController
  before_action :is_admin
  
  def index
  end
  
  def create
    require 'csv'
    
    if(params[:file] == nil)
      flash[:error] = "No file was chosen"
      redirect_to uploads_path
    else    
      @uploaded_doc = params[:file]
      @assignments_created = Assignment.import(@uploaded_doc)
      redirect_to assignments_path, :notice => @assignments_created.to_s + " assignments were created"
    end
  end
  
  def show
  end
end