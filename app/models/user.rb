class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :matches, dependent: :nullify
  has_many :pairs, dependent: :nullify
  has_many :players, dependent: :nullify
  has_many :tournaments, dependent: :nullify
  has_many :seasons, dependent: :nullify

end
