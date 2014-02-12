class AddPropertiesToStudent < ActiveRecord::Migration
  def change
    add_column :students, :absent, :boolean
    add_column :students, :in_seat, :integer
  end
end
