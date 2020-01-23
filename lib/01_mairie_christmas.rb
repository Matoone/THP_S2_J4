# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  tds = page.xpath('//td')
  ar = []
  begin
    ar = tds.select { |td| td.text =~ /.+@.+\.\w+/ }
  rescue StandardError => e
    puts "Certains emails n'existent pas. Poursuite de la recherche..."
  end

  if !ar.empty?
    ar[0].text.strip
  else
    ''
  end

end

def get_townhalls_urls
  puts 'Getting urls ...'
  links = {}
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
  table = page.xpath('//a[@class="lientxt"]')
  table.each do |link|
    # puts "#{link.txt} \t "
    name = link.text
    lnk = link.xpath('@href').to_s
    lnk_formatted = lnk.sub('.', 'http://annuaire-des-mairies.com')
    links[name.downcase.strip.gsub(' ', '_')] = lnk_formatted
  end
  puts 'Got the urls ! Still working...'
  links
end

def get_all_emails
  puts 'La recherche a débuté...'
  emails = []
  townhalls_urls = get_townhalls_urls
  townhalls_urls.each do |key, value|
    mail = get_townhall_email(value)
    h = {}
    h[key] = mail
    emails.push(h)
  end
  puts 'Got the emails! '
  emails
end
p get_all_emails

