class Assignment < ActiveRecord::Base
  belongs_to :student
  
  require 'csv'
  
  def self.import(file)    
    @original_filename = file.original_filename
    @num_rows = 0
    
    CSV.foreach(file.path, headers: true) do |row|
      @student = Student.find_by_email(row["Email"]) || Student.new
      
      @new_assignment = Assignment.new
      @new_assignment.student_id = @student.id
      @new_assignment.name = row["Assignment Name"]
      @new_assignment.total = row["Total"]
      @new_assignment.score = row["Score"]
      @new_assignment.save
      
      @num_rows += 1
    end
    return @num_rows
  end
end