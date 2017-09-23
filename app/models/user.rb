class User < ActiveRecord::Base
  has_many :projects
  has_many :tasks, through: :projects

  has_secure_password

  validates :username, { presence: true, uniqueness: true }
  validates :password, { presence: true, length: { minimum: 6 } }

end