class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: { message: "É obrigatorio o uso dun email" }
  validates :email, uniqueness: { message: "O email xa existe na base de datos", case_sensitive: false }
end
