class User < ActiveRecord::Base
    has_many :properties
    before_save { self.email = email.downcase }
    validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximun: 25 }
    VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximun: 105 },
            format: { with: VALID_EMAIL_REGEX }
end