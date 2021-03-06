class Category < ActiveRecord::Base
	
	#Gem FriendlyId
	include FriendlyId
	friendly_id :description, use: :slugged

	#Associations
	has_many :ads

	#Validates
	validates_presence_of :description

	#Scopes

	scope :order_by_description, -> {order(:description)}
end
