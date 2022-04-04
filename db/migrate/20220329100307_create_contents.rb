class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.integer :user_id, null: false
      t.integer :project_id, null: false
      t.string :title, null: false
      t.text :body

      t.timestamps
    end
  end
end
