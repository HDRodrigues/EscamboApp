class Member < ActiveRecord::Base

	# Configuracao para quem vai avaliar o anuncio
  ratyrate_rater

	#Associations
  has_many :ads
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
