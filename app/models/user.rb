class User < ApplicationRecord
  has_many :words

  has_secure_password

  EMAIL_REG = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i


  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 25
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 50
  validates :username,  :presence => true,
            :uniqueness => true,
            :length => {:within => 2...25}

  validates :email, :presence => true,
            :length => {:maximum => 50},
            :uniqueness => true,
            :format => { :with => EMAIL_REG},
            :confirmation => true
  scope :sorted, lambda { order("first_name ASC") }


end
