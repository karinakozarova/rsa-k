  require_relative "../app/helpers/rsas_helper.rb"

RSpec.describe rsas_helper do

  describe "new_key" do
    it "returns an array with exactly 3 values" do
      helper = RSA.new(1,2,3).new_key.size()
      expect(helper).to eq 3
    end

    it "values[0] of the key should be positive" do
      helper = RSA.new(1,2,3).new_key
      expect(helper[0]).to be >= 0
    end

    it "values[1] of the key should be positive" do
      helper = RSA.new(1,2,3).new_key
      expect(helper[1]).to be >= 0
    end

    it "values[2] of the key should be positive" do
      helper = RSA.new(1,2,3).new_key
      expect(helper[2]).to be >= 0
    end

  end

 describe "code coverage" do
    it "of class RSA" do
      helper = RSA.new
      expect(helper.are_coprime(9)).to eql false
    end
  end

  describe "is instance " do
    it "of class RSA" do
      helper = RSA.new
      expect(helper).to be_instance_of(RSA)
    end
  end

  describe "encrypt" do
    keys = RSA.new(0, 0, 0).new_key
    rsa = RSA.new keys[0], keys[1], keys[2]

    it "length of string does not change" do
      testing_string = "lorem ipsulm"
      expect(rsa.encrypt(testing_string).split(",").length).to eql testing_string.length
    end


    it "length of empty string does not change" do
      testing_string = ""
      expect(rsa.encrypt(testing_string).split(",").length).to eql testing_string.length
    end


    it "length of numeric string does not change" do
      testing_string = "1234567890"
      expect(rsa.encrypt(testing_string).split(",").length).to eql testing_string.length
    end

    it "encrypting the decrypted encrypted string" do
      temp = RSA.new 0, 0, 0
      keys = temp.new_key
      rsa = RSA.new keys[0], keys[1], keys[2]
      string =  "to be encrypted many timesss"
      expect(rsa.encrypt (rsa.decrypt(rsa.encrypt string))).to eq rsa.encrypt string
    end

  end

  describe "decrypt" do
    temp = RSA.new 0, 0, 0
    keys = temp.new_key
    rsa = RSA.new keys[0], keys[1], keys[2]

    it "Christmas easter egg :) " do
      string =  "We wish you a Merry Christmas!"
      expect(rsa.decrypt(rsa.encrypt string)).to eq string
    end

    it "testing string" do
      string =  "I want to sleep..."
      expect(rsa.decrypt(rsa.encrypt string)).to eq string
    end

    it "testing numeric string" do
      string =  "11.22.345.5556546345.1999"
      expect(rsa.decrypt(rsa.encrypt string)).to eq string
    end

  end

  describe " both decrypt and encrypt" do
    tester = RSA.new(1,2,3)


    it "make sure when decrypted the encrypted string remains the same" do
      res1 = tester.decrypt("sample string")
      res2 = tester.decrypt("sample string")
      expect(res1).to eq res2
    end


    it "string with numbers" do
      res1 = tester.decrypt("13434343434543324677534354743453")
      res2 = tester.decrypt("13434343434543324677534354743453")
      expect(res1).to eq res2
    end


    it "cyrilic string" do
      res1 = tester.decrypt("кфйгдлгйсдлф")
      res2 = tester.decrypt("кфйгдлгйсдлф")
      expect(res1).to eq res2
    end

    it "empty string" do
      res1 = tester.decrypt("")
      res2 = tester.decrypt("")
      expect(res1).to eq res2
    end

    it "mixed(nums+letters)string" do
      res1 = tester.decrypt("asdsd343sddfsf")
      res2 = tester.decrypt("asdsd343sddfsf")
      expect(res1).to eq res2
    end


  end



  describe "initialize" do
    it "initialize with values 1 2 3 " do
      helper = RSA.new(1,2,3)
      expect(helper.n).to eq 1
      expect(helper.e).to eq 2
      expect(helper.d).to eq 3
    end

    it "initialize with values 999 999 999 " do
      helper = RSA.new(999,999,999)
      expect(helper.n).to eq 999
      expect(helper.e).to eq 999
      expect(helper.d).to eq 999
    end

    it "initialize with values 0 0 0 " do
      helper = RSA.new(0,0,0)
      expect(helper.n).to eq 0
      expect(helper.e).to eq 0
      expect(helper.d).to eq 0
    end

    it "initialize without values" do
      helper = RSA.new
      expect(helper.n).to eq 0
      expect(helper.e).to eq 0
      expect(helper.d).to eq 0
    end
  end



  describe "n" do
    it "initialize with values 81 2 3 " do
      helper = RSA.new(81,2,3)
      expect(helper.n).to eq 81
    end

    it "initialize with values 1024 1024 1024" do
      helper = RSA.new(1024,1024,1024)
      expect(helper.n).to eq 1024
    end

    it "expect to be of type Fixnum" do
      expect(RSA.new(999,999,999).n).to be_a_kind_of(Fixnum)
    end
  end



  describe "e" do
    it "initialize with values 1 77 3" do
      helper = RSA.new(1,77,3)
      expect(helper.e).to eq 77
    end

    it "initialize with values 999 999 999" do
      helper = RSA.new(999,999,999)
      expect(helper.e).to eq 999
    end

    it "expect to be of type Fixnum" do
      expect(RSA.new(999,999,999).e).to be_a_kind_of(Fixnum)
    end
  end



  describe "d" do
    it "initialized with values 1 2 342434234324 " do
      helper = RSA.new(1,2,342434234324)
      expect(helper.d).to eq 342434234324
    end

    it "999 999 999 initialize" do
      helper = RSA.new(999,999,999)
      expect(helper.d).to eq 999
    end

    it "expect to be of type Fixnum" do
      expect(RSA.new(999,999,999).d).to be_a_kind_of(Fixnum)
    end
  end



end