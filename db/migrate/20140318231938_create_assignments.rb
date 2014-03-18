class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :student
      t.string :name
      t.integer :score
      t.integer :total
    end
    
    add_index :assignments, :student_id
  end
end
