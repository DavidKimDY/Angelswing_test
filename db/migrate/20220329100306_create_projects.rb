class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.integer :user_id , null: false
      t.string :title, null: false
      t.text :description, null: false
      t.integer :project_type, null: false
      t.string :location
      t.string :thumbnail

      t.timestamps
    end
  end
end
