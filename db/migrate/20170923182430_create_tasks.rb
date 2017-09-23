class CreateTasks < ActiveRecord::Migration[5.1]
  def change
  	create_table :tasks do |t|
      t.string :name
      t.string :time_allocation
      t.integer :project_id
  	end
  end
end
