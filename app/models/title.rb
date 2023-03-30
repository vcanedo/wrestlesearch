class Title < ApplicationRecord
  validates :name, presence: true

  has_many :reigns
  has_many :wrestlers, through: :reigns
end
