class User < ActiveRecord::Base
    has_many :visits
    has_many :breweries, through: :visits

    validates_presence_of :username, :email, :password
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
    validates_format_of :email, :with => /@/

    has_secure_password
end