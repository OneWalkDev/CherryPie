class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  def password_required?
    super && confirmed?
  end

  def active_for_authentication?
    super && confirmed?
  end

  def inactive_message
    confirmed? ? super : :needs_confirmation
  end
end
