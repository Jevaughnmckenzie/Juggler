class RenameActiveColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :projects, :active?, :active_status
  end
end
