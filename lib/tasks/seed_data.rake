namespace :db do
  desc "Rellena datos para desarrollo"
  task populate: :environment do
    make_users
    make_categories
    make_products
    # make_categorizations
  end
  def make_users
    User.create!(name: "Usuario",
    login: "login",
    direccion: "Algun lugar de Cuenca",
    edad: 24,
    cuenta_bancaria: "2365558899",
    password: "contraseña",
    password_confirmation: "contraseña")
    99.times do |n|
      User.create!(name: Faker::Name.name+"-#{n}",
      login: Faker::Internet.user_name+"#{n}",
      direccion: Faker::Address.street_address(include_secondary = true),
      edad: Faker::Number.number(2),
      cuenta_bancaria: Faker::Finance.credit_card,
      password: "contraseña",
      password_confirmation: "contraseña")
    end
  end
  def make_categories
    60.times do |n|
      Category.create!(titulo: Faker::Lorem.word+"-#{n}", descripcion: Faker::Lorem.paragraph)
    end
  end

  def make_products
    50.times do |n|
      product = Product.new(titulo: Faker::Commerce.product_name+"-#{n}", descripcion: Faker::Lorem.paragraph, precio:Faker::Number.number(3))
      10.times do |y|
        product.categories << Category.find_by_id(n+y+1)
      end
      product.save!
    end
  end

end
