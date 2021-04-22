require 'rubocop'
require 'pry'
require 'rspec'
require 'nokogiri' 
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))   

def get_depute_name(page)
  array_name = page.xpath('//*[@id="deputes-list"]/div/ul/li/a').map {|name| name.text}
end

def get_depute_first_name(array_name)
  array_first_name=[]
  array_name.each {|name| array_first_name<<name.split[1]}
  return array_first_name
end

def get_depute_last_name(array_name)
  array_last_name=[]
  array_name.each {|name| array_last_name<<name.split[2..name.size].join(" ")}
  return array_last_name
end

def get_mail_url(page)
  array_url = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
  numb_url = array_url.map {|url| url.to_s.split('OMC_PA').last.split('>').first[0...-1]}
  return array_url_mail = numb_url.map {|numb| numb="https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA#{numb}"}
end

def get_email(array_url_mail)
  email_array=[]
  puts "Veuillez patienter s'il vous plait...... Je bouffe votre bande passante"
  array_url_mail.map do |url|
    page = Nokogiri::HTML(URI.open(url))
    email_array<<page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  end
  return email_array
end

def array_hash_depute(email_array, array_first_name, array_last_name)
  array_depute=[]
  array_first_name.size.times do |i|
    array_depute << hash = {
      "first_name" => array_first_name[i],
      "last_name"  => array_last_name[i],
      "email"      => email_array[i]}
  end
  puts array_depute
  return array_depute
end

# array_url_mail = get_mail_url(page)
# email_array = get_email(array_url_mail)
# array_name = get_depute_name(page)
# array_first_name = get_depute_first_name(array_name)
# array_last_name = get_depute_last_name(array_name)
# array_hash_depute(email_array, array_first_name, array_last_name)