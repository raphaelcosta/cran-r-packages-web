class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :title
      t.string :description
      t.string :date_publication
      t.text :authors, array: true, default: []
      t.string :maintainer_name
      t.string :maintainer_email

      t.timestamps
    end
  end
end
