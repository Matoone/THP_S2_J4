# frozen_string_literal: true

require_relative '../lib/00_dark_trader.rb'

describe 'the get_crypto_values function' do
  it 'should return a Hash containing each crypto and its value' do
    expect(get_crypto_values).to be_truthy
    expect(get_crypto_values).to be_kind_of(Hash)
  end
end

describe 'the proper_format function' do
  it 'should convert a hash into an array containing one hash for each crypto' do
    expect(proper_format('BTC' => 1201, 'ETH' => 214.35)).to be_kind_of(Array)
    expect(proper_format('BTC' => 1201, 'ETH' => 214.35)).to eq([{ 'BTC' => 1201 }, { 'ETH' => 214.35 }])
  end
end
