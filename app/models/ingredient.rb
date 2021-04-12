class Ingredient < ApplicationRecord
	belongs_to :recipe, optional: true

	validates :name, presence: true
end
