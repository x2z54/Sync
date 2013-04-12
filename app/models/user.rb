class User < ActiveRecord::Base
  attr_accessible :email, :password
  has_secure_password

  validates :email, :presence => true, :uniqueness => true
  validates :password, :length => { :maximum => 14, :minimum => 6 }
end