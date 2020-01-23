require 'open-uri'
require 'nokogiri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  tds = page.xpath('//td')
  ar = []
  begin
    ar = tds.select{|td| td.text =~ /.+@.+\.\w+/}
  rescue => exception
    puts "Certains emails n'existent pas. Poursuite de la recherche..."
  end
  
  if ar.length > 0
    return ar[0].text.strip
  else
    return ""
  end
  
  #filtered = tds.text.reject{|entry| entry.include?()}
end

def get_townhalls_urls
  puts "Getting urls ..."
  links = {}
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  table = page.xpath('//a[@class="lientxt"]')
  table.each{|link|
     #puts "#{link.txt} \t "
     name = link.text
     lnk = link.xpath('@href').to_s
     lnk_formatted = lnk.sub('.', 'http://annuaire-des-mairies.com')
     links[name.downcase.strip.gsub(' ', '_')] = lnk_formatted
    }
    puts "Got the urls ! Still working..."
    links
end

def get_all_emails
  puts "La recherche a débuté..."
  emails = []
  townhalls_urls = get_townhalls_urls()
  townhalls_urls.each{|key, value|
    mail = get_townhall_email(value)
    h = Hash.new
    h[key] = mail
    emails.push(h)
  }
  puts "Got the emails! "
  return emails
end
p get_all_emails
#get_townhall_email("http://annuaire-des-mairies.com/95/arnouville-les-gonesse.html")
#get_townhall_urls