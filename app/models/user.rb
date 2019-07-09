class User < ActiveRecord::Base
    has_many :visits
    has_many :breweries, through: :visits
end