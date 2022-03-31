class User < ApplicationRecord
    attr_accessor :firstName, :lastName
    has_many :projects
    has_many :contents
    has_secure_password
end