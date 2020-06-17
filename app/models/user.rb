class User < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :play_books, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :password_complexity
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[.#?!@$%^&*-]).{8,16}$/

    errors.add :password, 'Complexity requirement not met. Length should be 8-16 characters and include: 1 uppercase, 1 lowercase and 1 special character'
  end
end
