class NewerAddPropertiesToAttendance < ActiveRecord::Migration
  def change
    remove_column :students, :attended_on, :date
    remove_column :students, :seat, :integer
    add_column :attendances, :attended_on, :date
    add_column :attendances, :seat, :integer
  end
end
