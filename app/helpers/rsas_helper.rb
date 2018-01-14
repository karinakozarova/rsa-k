module RsasHelper

class RSA
  @n
  @e
  @d

  def initialize n = 0, e = 0, d =0
    @n = n
    @e = e
    @d = d
  end

  def n
    @n
  end

  def e
    @e
  end

  def d
    @d
  end

  def new_key
    p = gen_distinct_primes
    q = gen_distinct_primes

    λ = calc_λ(p,q)
    e = generate_random_coprime
    d  = calculate_d(λ,e)

    initialize p*q,e,d
    [p * q, e, d]

  end

  def encrypt message
    encrypted_array = Array.new

    message.each_char do |ch|
      ch = ch.ord #.ord -> to ascii
      encrypted_char = ch ** e % n
      encrypted_array << encrypted_char
    end

    encrypted_array = encrypted_array.to_s[1..-2]
    encrypted_array
  end

  def decrypt message
    decrypted_array = String.new
    message.split(', ').each do |num|
      decrypted_char = num.to_i ** d % n
      decrypted_array << decrypted_char.chr # .chr -> to char
    end
    decrypted_array
  end

#private

  def gen_distinct_primes
    (Prime.first 120)[10 + Random.new.rand(110)]
  end

  def are_coprime a,b = 780
    if gcd(a,b) == 1 then true
    else false end
  end

  def generate_random_coprime
    is_false = false
    while is_false==false do
        num = rand(20..20202).to_i
        if is_prime?(num) && are_coprime(num,780) then is_false = true end
    end
    num
  end

  def is_prime?(number)
    if number <= 1 then return false end
    i = 2

    while i < number
      if number % i == 0 then return false end
      i += 1
    end

    return true
  end

  def gcd a, b #stack exchange credit
    b == 0 ? a : gcd(b, a.modulo(b))
  end

  def calculate_d λ,e
    for i in 2..λ
      calc = (i * e) % λ
      if calc== 1
        d = i
        break
      end
    end
    @d = d
    d
  end

  def calc_λ p,q
    (p - 1).lcm(q - 1)
  end
end
end
