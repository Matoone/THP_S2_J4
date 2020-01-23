require_relative '../lib/02_cher_depute.rb'

describe "the get_deputies_urls function" do
  it "should return an array containing hashes with first_name, last_name and link" do
    expect(get_deputies_urls).to be_truthy
    expect(get_deputies_urls).to be_kind_of(Array)
    expect(get_deputies_urls[0]).to be_kind_of(Hash)
    expect(get_deputies_urls[0].length).to eq(3)
  end
end

describe "the format_name(name) function" do
  it "should return a hash containing first_name and last_name" do
    expect(format_name("M. Anthony Laval")).to be_kind_of(Hash)
    expect(format_name("M. Anthony Laval")).to be_truthy
    expect(format_name("M. Anthony Laval")).to eq({"first_name" => "Anthony", "last_name" => "Laval"})
    
  end
end

describe "the get_email_from_url(url) function" do
  it "should return a string containing the found email or a specific empty string if it is'nt found" do
    expect(get_email_from_url("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")).to be_kind_of(String)
    expect(get_email_from_url("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")).to eq("damien.abad@assemblee-nationale.fr")
    expect(get_email_from_url("https://devhints.io/xpath")).to eq("")
  end
end

# didnt test the main function to not overload the servers of the republic ! 