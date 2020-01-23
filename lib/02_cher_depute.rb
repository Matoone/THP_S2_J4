require 'open-uri'
require 'nokogiri'


def get_deputies_urls
  puts "Getting urls..."
  list = []
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  all_links = page.xpath('//div[@id="deputes-list"]//li/a')
  all_links.each{|link|
    lnk = link.xpath('@href').to_s
    name = link.text
    h = format_name(name)
    h["link"] = "http://www2.assemblee-nationale.fr" + lnk
    list.push(h)
  }
  puts "Got the urls!"
  list  
    #puts "#{link.text} \t\t #{lnk}"}
end

def format_name(name)
  puts "Formatting name #{name}..."
  h = Hash.new
  name_parts = name.split(' ')
  first_name = name_parts[1]
  last_name = name_parts[2..-1].join(' ')
  h["first_name"] = first_name
  h["last_name"] = last_name
  h
end

def get_email_from_url(url)
  puts "Getting email from #{url}"
  page = Nokogiri::HTML(open(url))
  links = page.xpath("//dl[@class='deputes-liste-attributs']/dd/ul/li/a")
  ar = []
  ar = links.select{|link| link.text =~ /.+@.+\.\w+/}
  if ar.length > 0
    mail = ar[0].text.strip
    puts "Email found: #{mail}"
    mail
  else
    puts "No email detected!"
    ""
  end 
end

def deputy_scrapper_main
  time = Time.now()
  puts "Search has begun ..."
  hash_list = get_deputies_urls
  hash_list.each{|hash|
    puts "Treating #{hash["last_name"]} #{hash["first_name"]} ..."
    if hash["link"] != ""
      email = get_email_from_url(hash["link"])
      hash["email"] = email
    end
  }
  h = hash_list.each{|entry| entry.delete("link")}
  exec_time = Time.now() - time
  t = Time.new(0)
  t += exec_time
  
  puts "Terminé en #{t.strftime("%H:%M:%S").strip} !"
  puts h
  #hash_list.each{||}
end

# t = Time.new(0)
# t += 414.5642
# t.strftime("%H:%M:%S").strip
deputy_scrapper_main
#p get_email_from_url("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")
#p get_deputies_urls
#p format_name("M. Fabien Matras")
