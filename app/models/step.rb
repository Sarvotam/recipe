class Step < ApplicationRecord
  belongs_to :recipe, optional: true

  validates :direction, presence: true
end
