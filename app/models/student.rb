class Student < ActiveRecord::Base
  has_secure_password
  
  has_many :attendances, dependent: :destroy
  
  def self.in_seat(seat, date)
    Student.joins(:attendances).where(attendances: {seat: seat, attended_on: date})
  end
  
  def self.absent(date)
    Student.joins(:attendances).where.not(attendances: {attended_on: date})
  end
end
