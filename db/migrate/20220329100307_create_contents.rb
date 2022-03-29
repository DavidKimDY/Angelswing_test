class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
