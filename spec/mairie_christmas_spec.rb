require 'rubocop'
require 'pry'
require_relative '../lib/mairie_christmas'

describe "the get_townhall_email method" do 
  it "return an townhall email" do
    expect(get_townhall_email(['https://www.annuaire-des-mairies.com/95/gonesse.html'])).to eq(["contact@villaeroport.org"])
  end
  it "return an townhall email" do
    expect(get_townhall_email(['https://www.annuaire-des-mairies.com/95/longuesse.html'])).to eq(['mairie.longuesse@orange.fr'])
  end
end

describe "the array_hash_town_mail method" do 
  it "return array of the town & email" do
    expect(array_hash_town_mail(["Breancon"],["mairie.breancon@wanadoo.fr"])).to eq([{"Breancon" => "mairie.breancon@wanadoo.fr"}])
  end
end