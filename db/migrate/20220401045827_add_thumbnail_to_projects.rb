class AddThumbnailToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :thumbnail, :string
  end
end
