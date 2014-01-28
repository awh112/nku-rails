class StudentsController < ApplicationController
  def index
  end
  
  def new
  end
  
  def create
    render text: params[:student].inspect
  end
end
