class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates :password, :confirmation => true, :on => :save
  validates :password_confirmation, :presence => true, :on => :save
  validates :email, :presence => true, :uniqueness => true
  validates :password, :length => { :maximum => 14, :minimum => 6 }
end