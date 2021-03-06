class User < ActiveRecord::Base
  before_create :create_remember_token
  has_one :car, dependent: :destroy
  has_secure_password

  def validate_password?
    password.present? || password_confirmation.present?
  end

  validates :password, presence: true, length: { minimum: 6, if: :validate_password? }
  validates :name, :login, :direccion, :cuenta_bancaria, :edad, presence: true
  validates :edad, numericality: true

  def quitar_linea(linea)
    car.lines.find_by_id(linea.id).destroy!
  end

  def agregar_producto(product, cantidad)
    if self.car.nil?
      self.car.create!
    end
    car.lines.create!(product:product, cantidad:cantidad)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
