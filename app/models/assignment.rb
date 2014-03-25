class Assignment < ActiveRecord::Base
  belongs_to :student
  
  require 'csv'
  
  def self.import(file)
    #@spreadsheet = open_spreadsheet(file)
    #@header = spreadsheet.row(1)
    
    @original_filename = file.original_filename
        
    File.open(Rails.root.join('public', 'uploads', file.original_filename), 'r') do |file|
      file.write(file.read)

    
      debugger
      CSV.foreach("public/" + @original_filename) do |row|
      debugger        
    end      
    end
  end
  
  def self.open_spreadsheet(file)
    debugger
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end