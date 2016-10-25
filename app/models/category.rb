class Category < ActiveRecord::Base
	has_and_belongs_to_many :products, join_table: "categorization"
	validates :titulo, presence: true
end
