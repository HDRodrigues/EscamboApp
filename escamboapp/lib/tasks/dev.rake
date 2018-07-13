namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    images_path = Rails.root.join('public','system')
    puts "Executando o setup para desenvolvimento..."

    puts "Apagando BD...#{%x(rake db:drop)}" 
    puts "Apagando Imagens...#{%x(rm -rf #{images_path})}"
    puts "Criando  BD...#{%x(rake db:create)}" 
    puts %x(rake db:migrate) 
    puts %x(rake db:seed)
    puts %x(rake dev:generate_admins) 
    puts %x(rake dev:generate_members) 
    puts %x(rake dev:generate_ads)

    puts "Setup executado com sucesso!"
  end



  desc "Cria Administradores Fake"
  task generate_admins: :environment do
  	puts "Cadastrando ADMINISTRADORES FAKES..."

  	10.times do 
  		Admin.create!(
  			email: Faker::Internet.email,
  			name: Faker::FunnyName.name,
  			password: "123456", 
  			password_confirmation: "123456",
  			role: [0,1].sample)
    end
	  puts "ADMINISTRADORES FAKES cadastrado com sucesso!"
  end


  desc "Cria Membros Fake"
  task generate_members: :environment do 
      puts "Cadastrando Membros ..."
      100.times do
        Member.create!(
          email: Faker::Internet.email,
          password: "123456",
          password_confirmation: "123456"
        )
      end
      puts "Membros Cadastrados com sucesso..."
  end

  desc "Cria Anuncios Fake"
  task generate_ads: :environment do
  	puts "Cadastrando ANUNCIOS..."

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(6)}.jpeg"),'r')
      )
    end

  	100.times do 
  		Ad.create!(
  			title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
  			member: Member.all.sample,
  			category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(6)}.jpeg"),'r')
  		)
  	end
  	puts "ANUNCIOS cadastrados com sucesso!"
  end

  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end
end
