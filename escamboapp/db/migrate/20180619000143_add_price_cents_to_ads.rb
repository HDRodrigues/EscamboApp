class AddPriceCentsToAds < ActiveRecord::Migration
  def change
  	#Adiciona na tabela ads a conluna price_cents como inteiro
    add_column :ads, :price_cents, :integer, default: 0
  end
end
