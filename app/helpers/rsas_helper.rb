module RsasHelper
  require 'prime'
  
  class RSA
    attr_reader :n, :e, :d
  
    def initialize n, e, d
      @n = n
      @e = e
      @d = d
    end
  
    def self.new_key
      p = Prime.take(rand(128..256)).last
      q = Prime.take(rand(128..256)).last
  
      # For security reasons p and q should be different
      q = Prime.take(rand(128..256)).last while p == q
  
      n = p * q
      least_common_multiple = (p - 1).lcm(q - 1)
  
      e = 65537
  
      d = mod_inverse(e, least_common_multiple)
  
      [n, e, d]
    end
  
    def encrypt message
      result = []
      message.each_byte do |c|
        result.push(c**@e % @n)
      end
  
      result.join('-')
    end
  
    def decrypt message
      result = ''
      message.split('-').each do |c|
        result += (c.to_i**@d % @n).chr
      end
  
      result
    end
  
    private
  
    def self.mod_inverse a, m
      a %= m
      for i in 1..m do
        return i if (a * i) % m == 1
      end
    end
  end
end
