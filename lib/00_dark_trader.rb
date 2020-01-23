require 'open-uri'
require 'nokogiri'

def get_crypto_values
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  cryptos_names = []
  cryptos_values = []
  cryptos = page.xpath('//tr/td[3]/div')
  values = page.xpath('//tr/td[5]/a')
  cryptos.each{|val|
    txt = "#{val.text}"
    cryptos_names.push(txt)
    #puts "#{row.text} \n \n"
  }
  values.each{|val|
    txt = "#{val.text}".sub(",", "")
    txt[0]=''
    cryptos_values.push(txt.to_f)
  }
  # p cryptos_names
  # p cryptos_values

  result = Hash[cryptos_names.zip cryptos_values]
  result
end

def proper_format (hash)
  a = []
  hash.each{|key, val|
  h = Hash.new
  h[key] = val
  a.push(h)
  }
  return a
end
p proper_format(get_crypto_values)