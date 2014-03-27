class UploadsController < ApplicationController
  def index
  end
  
  def create
    require 'csv'
    
    @uploaded_doc = params[:file]
    @assignments_created = Assignment.import(@uploaded_doc)
    debugger
    redirect_to assignments_path, :notice => @assignments_created.to_s + " assignments were created"
  end
  
  def show
  end
end