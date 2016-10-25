class Line < ActiveRecord::Base
  belongs_to :product
  belongs_to :car
end
