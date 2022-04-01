class User < ApplicationRecord
    attr_accessor :firstName, :lastName
    validates :first_name, :last_name, :email, :password, presence: true
    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    has_many :projects
    has_many :contents
    has_secure_password
end
