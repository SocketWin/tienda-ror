class InicioController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page: 25)
  end

  def sign_up
  end

  def sign_in
    # @user = User.find_by_login(params[:login])
    # if @user.password == params[:password]
    #   give_token
    # else
    #   redirect_to root_path
    # end
  end

  def buscar_producto
    @titulo = params[:titulo]
    @products = Product.where("titulo LIKE '%#{@titulo}%'").paginate(page: params[:page], per_page: 25)
  end
end
