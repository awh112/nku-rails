class Student < ActiveRecord::Base
  has_secure_password
  
  has_many :attendances, dependent: :destroy
  
  def self.in_seat(seat, date)
  end
  
  def self.absent(date)
  end
end
