class Reign < ApplicationRecord
  validates :duration, presence: true

  belongs_to :wrestler
  belongs_to :title
end
