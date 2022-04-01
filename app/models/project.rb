class Project < ApplicationRecord
    belongs_to :user
    has_many :contents, dependent: :destroy
    validates :title, :project_type, :location, :thumbnail, presence: true, on: :create
end
