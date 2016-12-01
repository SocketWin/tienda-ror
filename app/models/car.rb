class Car < ActiveRecord::Base
  belongs_to :user
  has_many :lines, dependent: :destroy

  def suma_total
    total = 0
    for line in lines
      total += (line.product.precio * line.cantidad)
    end
    total.round(2)
  end

end
