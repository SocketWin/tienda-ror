class InicioController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page: 25)
  end

  def sign_up
  end

  def sign_in
  end

  def my_car
  end

  def buscar_producto
    @titulo = params[:titulo]
    @products = Product.where("titulo LIKE '%#{@titulo}%'").paginate(page: params[:page], per_page: 25)
  end
end
