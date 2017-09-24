class AddActiveAndInactiveColumns < ActiveRecord::Migration[5.1]
  def change
  	add_column :projects, :active?, :boolean
  end
end
