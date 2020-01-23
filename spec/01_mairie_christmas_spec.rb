# frozen_string_literal: true

require_relative '../lib/01_mairie_christmas.rb'

describe 'the get_townhall_email function' do
  it "should return an email string or a specific empty string if it wasn't found" do
    expect(get_townhall_email('http://annuaire-des-mairies.com/95/arnouville-les-gonesse.html')).to be_truthy
    expect(get_townhall_email('http://annuaire-des-mairies.com/95/arnouville-les-gonesse.html')).to be_kind_of(String)
    expect(get_townhall_email('http://annuaire-des-mairies.com/95/arnouville-les-gonesse.html')).to eq('webmaster@villedarnouville.com')
  end
end

describe 'the get_all_emails function' do
  it 'should return an array containg hash of city => email' do
    expect(get_all_emails).to be_kind_of(Array)
    expect(get_all_emails).to be_truthy
  end
end
