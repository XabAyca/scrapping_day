require 'nokogiri' 
require 'open-uri'
require 'rubocop'
require 'pry'
require 'rspec'


page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))   

def get_townhall_email(url_array)
  email_array=[]
  puts "Veuillez patienter chargement en cours ........"
  url_array.map do |url|
    page = Nokogiri::HTML(URI.open("#{url}"))
    email_array<< page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  end
  return email_array
end

def get_townhall_url(page)
  url_array =page.xpath('//*[@class="lientxt"]').map {|town| town="https://www.annuaire-des-mairies.com/95/#{town.text.downcase.tr(' ',"-")}.html"}
end

def get_townhall_name(page)
  name_array =page.xpath('//*[@class="lientxt"]').map {|name| name.text}
end

def array_hash_town_mail(name_array, email_array)
  new_array=[]
  name_array.size.times {|i| new_array<<Hash[name_array[i],email_array[i]]}
  #puts new_array <==== pour afficher le résultat
  return new_array
end

# url_array= get_townhall_url(page)
# name_array= get_townhall_name(page)
# email_array= get_townhall_email(url_array)
# array_hash_town_mail(name_array, email_array)