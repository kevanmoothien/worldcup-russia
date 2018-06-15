class User < ActiveRecord::Base
  has_many :bets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def username
    email.split('@')[0]
  end

  def active_for_authentication?
    super && active? # i.e. super && self.is_active
  end

  def inactive_message
    'Sorry, this account has been deactivated. Maybe you have not yet paid.'
  end
end
