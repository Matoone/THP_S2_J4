# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

def get_crypto_values
  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  cryptos_names = []
  cryptos_values = []
  cryptos = page.xpath('//tr/td[3]/div')
  values = page.xpath('//tr/td[5]/a')
  cryptos.each do |val|
    txt = val.text.to_s
    cryptos_names.push(txt)
    # puts "#{row.text} \n \n"
  end
  values.each do |val|
    txt = val.text.to_s.sub(',', '')
    txt[0] = ''
    cryptos_values.push(txt.to_f)
  end

  result = Hash[cryptos_names.zip cryptos_values]
  result
end

def proper_format(hash)
  a = []
  hash.each do |key, val|
    h = {}
    h[key] = val
    a.push(h)
  end
  a
end
p proper_format(get_crypto_values)
