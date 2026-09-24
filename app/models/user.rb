class User < ApplicationRecord
  has_many :rooms
  has_many :reservations

  has_one_attached :icon

  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
