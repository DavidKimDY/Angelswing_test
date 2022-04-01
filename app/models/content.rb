class Content < ApplicationRecord
    belongs_to :project
    belongs_to :user
    validates :title, :body, presence: true, on: :create
end
