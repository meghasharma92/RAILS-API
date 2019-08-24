class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_token_authenticatable
  has_many :reviews

  def generate_new_token
  	new_token = User.generate_unique_secure_token
  	update_attributes(authentication_token: new_token)
  end
end
