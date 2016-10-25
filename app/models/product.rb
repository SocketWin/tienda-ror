class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories, join_table: "categorization"
  # accepts_nested_attributes_for :categories
  has_many :lines, dependent: :destroy
  validates :precio, numericality: { greather_than_or_equal_to: 0 }
  validates :titulo, uniqueness: true
  validates :titulo, :descripcion, :imagen, :precio, :categories, presence: true
  validates_format_of :imagen, :with => %r{\.(png|jpg|jpeg)}i
  after_initialize {
	 	 self.imagen = "product.png" if self.imagen.blank?
	}
end
