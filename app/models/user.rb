class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	
  store :address, accessors: [ :code, :city, :district, :addr ], coder: JSON
  store :birthday, accessors: [ :year, :month, :day ], coder: JSON
  has_many :wishes
  has_many :products, through: :wishes
  has_one :order, :dependent => :destroy
end
