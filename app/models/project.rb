class Project < ApplicationRecord
    belongs_to :user
    mount_uploader :thumbnail, ThumbnailUploader
    has_many :contents, dependent: :destroy
    validates :title, :project_type, :location, :thumbnail, presence: true, on: :create
end
