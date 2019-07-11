class User < ActiveRecord::Base
    has_many :visits
    has_many :breweries, through: :visits

    validates_presence_of :username, :email, :password
    validates_uniqueness_of :username, :email { case_sensitive: false }

    has_secure_password
end