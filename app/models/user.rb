class User < ApplicationRecord
	
	has_secure_password
	acts_as_followable
	acts_as_follower
	acts_as_voter
	validates :name, 
	uniqueness: { case_sensitive: false }, 
	presence: true,
	 allow_blank: false,
	  format: { 
	  	with: /\A[a-zA-Z0-9]+\z/ 
	  }


	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates :email, 
	:presence => true,
	uniqueness: true,
	:length => { :maximum => 100 },
	:format => EMAIL_REGEX,
	:confirmation => true
end
