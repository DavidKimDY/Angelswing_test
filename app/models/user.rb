class User < ApplicationRecord
    has_many :projects
    has_many :contents
    has_secure_password
end
