require 'rubocop'
require 'pry'
require 'rspec'
require 'nokogiri' 
require 'open-uri'

################### Récupère l'url et fait une variable générale #####################
$page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   

################## Récupère le nom des cryptos ###################
def array_crypto_name()
  array_name = $page.xpath('//tbody/tr/td[3]//*[@class=""]').map {|name| name.text}
end 

################## Récupère les valeurs des cryptos ######################
def array_crypto_value()
  array_value = $page.xpath('//tbody/tr/td[5]/div//a[@class="cmc-link"]').map {|item| item.text.tr('$','')}
end

################## Lie les tableaux dans un hash ##################
def array_hash
  array_name = array_crypto_name()
  array_value = array_crypto_value()
  new_array=[]
  array_name.size.times {|i| new_array<<Hash[array_name[i],array_value[i]]}
  puts new_array.inspect
  return new_array
end

array_hash()