class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reports
  has_many :reminders, dependent: :destroy

  validates :first_name, :last_name, :username, :contact, :email, :password, presence: true
end
