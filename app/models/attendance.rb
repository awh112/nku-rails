class Attendance < ActiveRecord::Base
  belongs_to :student
  
  validates :seat, :inclusion => 1..4
  validates :seat, :numericality => {:only_integer => true}
  validates :seat, presence: true
end
