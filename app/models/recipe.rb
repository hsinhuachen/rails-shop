class Recipe < ApplicationRecord
	validates :title, presence: true
	has_many :ingredients, dependent: :destroy, inverse_of: :recipe
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	accepts_nested_attributes_for :ingredients
	mount_uploader :image, RecipephotoUploader

	default_scope -> { order('sorting DESC') }

	def status
		self.publish
	end

	def tag_ids=(ids)
	    self.tags = Array(ids).reject(&:blank?).map { |id|
	      (id =~ /^\d+$/) ? Tag.find(id) : Tag.new(name: id)
	    }
	end

	def ingredient(title, quantity, sorting=0)
        self.ingredients.create("title" => title, "quantity" => quantity, "sorting" => 0)
	end
end
