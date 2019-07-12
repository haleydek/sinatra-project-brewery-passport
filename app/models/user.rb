class User < ActiveRecord::Base
    has_many :visits
    has_many :breweries, through: :visits

    validates_presence_of :username, :email, :password, message: "All fields must be filled in to continue."
    validates :username, uniqueness: { case_sensitive: false }, message: "Sorry, this username already exists! Please try a different username."
    validates :email, uniqueness: { case_sensitive: false }, message: "This email already has an account. Please try logging in with this email or enter a different email."
    validates_format_of :email, with: /@/, message: "Please enter a valid email."

    has_secure_password
end