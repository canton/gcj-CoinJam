load 'prime.rb'
load 'set.rb'

def solve(n, j)
  min = (1 << (n-1)) + 1
  max = (1 << n) - 1

  answers = []
  number = min

  while number <= max
    values = (2..10).map { |base| to_number(number, n, base) }
    factors = values.map{ |v| find_factor(v) }
    if !factors.any?(&:nil?)
      ans = [number.to_s(2)] + factors
      answers << ans.join(' ')
      STDERR.puts "#{answers.count} -- #{Time.now}"
      break if answers.count == j
    end

    number += 2
  end

  answers
end

MAX_PRIME = 2000
@primes = Prime.each(MAX_PRIME).to_a
def find_factor(number)
  max = Math.sqrt(number).floor
  max = MAX_PRIME if max > MAX_PRIME
  @primes.each do |p|
    return nil if p > max
    return p if number % p == 0
  end
  nil
end

def to_number(number, length, base)
  value = 0
  length.times do |i|
    value += (base**i) * number[i]
  end
  value
end

begin
  # test
  value = to_number(0b1001, 4, 5)
  fail '#to_number failed' if value != 126

  factor = find_factor(7)
  fail '#find_factor failed' if factor != nil

  factor = find_factor(35)
  fail '#find_factor failed' if factor != 5
end

case_count = gets.chomp.to_i
case_count.times do |cc|
  buffer = gets.chomp
  STDERR.puts "#{cc+1}: #{Time.now}" if cc % 10 == 9
  ans = solve(*buffer.split.map(&:to_i))

  puts "Case ##{cc+1}:"
  puts ans
end
