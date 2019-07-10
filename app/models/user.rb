class User < ActiveRecord::Base
    has_many :visits
    has_many :breweries, through: :visits

    has_secure_password
end