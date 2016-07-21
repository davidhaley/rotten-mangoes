class User < ApplicationRecord

  has_many :reviews
  has_many :movies, through: :reviews

  after_destroy :notify_user_delete

  has_secure_password

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create
  
  def full_name
    "#{firstname} #{lastname}"
  end

  protected

  def notify_user_delete
    UserMailer.notify_user_delete(self).deliver
  end
end
