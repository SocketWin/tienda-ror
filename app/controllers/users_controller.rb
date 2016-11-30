class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit,:update,
                                        :actualizar_carrito, :my_car, :agregar_al_carrito]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit,:update]

  # def login
  #   @user = User.find_by_login(params[:login])
  #   if @user.password == params[:password]
  #     give_token
  #   else
  #     redirect_to home_url
  #   end
  # end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'Bienvenido a Red Social' }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def agregar_al_carrito
    @product = Product.find_by_id params[:product_id]
    @cantidad = params[:cantidad]
    render :js => "alert('Ha agregado #{@cantidad} #{@product.titulo} al carrito de compras.')"
  end

  def actualizar_carrito
    @line = Line.find_by_id params[:line_id]
    @cantidad = params[:cantidad].to_i
    if @line.car.user_id == current_user.id
      if @cantidad > 0
        @line.update_attribute(:cantidad, @cantidad)
        redirect_to :back, notice: "Se ha procedido a actualizar la cantidad."
      else
        @line.delete
        redirect_to :back, notice: "Se ha procedido a borrar la linea."
      end
    else
      render file: "#{Rails.root}/public/500", layout: false, status: :error
    end
  end

  def my_car
    @lines = User.find_by_id(1).car.lines.paginate(page: params[:page], per_page: 10)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :login, :edad, :direccion, :cuenta_bancaria, :password, :password_confirmation)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to root_url, notice: "Has sido redirigido por no tener los permisos adecuados" unless
        current_user? @user
  end


end
