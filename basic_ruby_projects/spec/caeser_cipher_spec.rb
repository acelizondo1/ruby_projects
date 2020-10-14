require './caeser_cipher.rb'

describe "#caeser_cipher" do 
  it "returns cipher with positive shift" do
    expect(caeser_cipher("test", 5)).to eql("yjxy")
  end

  it "returns cipher with negative shift" do
    expect(caeser_cipher("negative shift", -5)).to eql("izbvodqz ncdao")
  end

  it "does not shift special characters" do 
    expect(caeser_cipher("Shift with, puncuation!", 10)).to eql("Crspd gsdr, zexmekdsyx!")
  end

  it "handles large shifts" do
    expect(caeser_cipher("Large positive shifts", 120)).to eql("Bqhwu feiyjylu ixyvji")
  end

  it "handles large negative shifts" do
    expect(caeser_cipher("Large negative shifts", -150)).to eql("Rgxmk tkmgzobk ynolzy")
  end
end