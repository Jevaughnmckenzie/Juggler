class User < ActiveRecord::Base
  has_many :projects
  has_many :tasks, through: :projects

  has_secure_password
end