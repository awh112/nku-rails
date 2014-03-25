class UploadsController < ApplicationController
  def index
  end
  
  def create
    require 'csv'
    
    @uploaded_doc = params[:file]
    Assignment.import(@uploaded_doc)
  end
  
  def show
  end
end