class UseTextForPackagesDescription < ActiveRecord::Migration
  def change
    change_column :packages, :description, :text
  end
end
