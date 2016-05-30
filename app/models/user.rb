class User < ActiveRecord::Base
	devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
	has_many :tickets
	has_many :comments

  	before_save { email.downcase! }

	validates :name, presence: true, length: { maximum: 30 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end
