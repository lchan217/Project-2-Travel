class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :name, presence: true
  validates :username, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  has_many :completions
  has_many :goals
end
