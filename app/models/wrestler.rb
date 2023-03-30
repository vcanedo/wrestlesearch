class Wrestler < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true

  has_many :reigns
  has_many :titles, through: :reigns
end
