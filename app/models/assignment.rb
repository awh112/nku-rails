class Assignment < ActiveRecord::Base
  belongs_to :student
  
  require 'csv'
  
  def self.import(file)    
    @original_filename = file.original_filename
    @num_rows = 0
    
    CSV.foreach(file.path, headers: true) do |row|
      @student = Student.find_by_email(row["Email"]) || Student.new
      
      #find if this assignment has been uploaded for the current student
      @existing_assignment = Assignment.where("student_id = ? AND name=?", @student.id, row["Assignment Name"]).first
      
      if(@existing_assignment != nil)
        @existing_assignment.total = row["Total"]
        @existing_assignment.score = row["Score"]
        @existing_assignment.save
      else
        @new_assignment = Assignment.new
        @new_assignment.student_id = @student.id
        @new_assignment.name = row["Assignment Name"]
        @new_assignment.total = row["Total"]
        @new_assignment.score = row["Score"]
        @new_assignment.save
        @num_rows += 1
      end      
    end
    return @num_rows
  end
end