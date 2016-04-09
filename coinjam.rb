#!/user/bin/env ruby

load 'prime.rb'
load 'set.rb'

def solve(n, j)
  min = (1 << (n-1)) + 1
  max = (1 << n) - 1

  # primes = Set.new Prime.each(Math.sqrt(to_number(max, n, 10)).floor)
  # STDERR.puts "#{Time.now} - primes done"

  answers = []
  number = min
  while number <= max
    values = (2..10).map { |base| to_number(number, n, base) }
    if !values.any? { |v| Prime.prime?(v) }
      answers << number
      STDERR.puts "#{answers.count} -- #{Time.now}"
      break if answers.count == j
    end

    number += 2
  end

  done = 0
  answers.map do |ans|
    values = (2..10).map { |base| to_number(ans, n, base) }
    array = [ans.to_s(2)] + values.map{ |v| Prime.each(Math.sqrt(v).floor).find{ |p| v % p == 0 } }
    done += 1
    STDERR.puts "done - #{done} - #{Time.now}"
    array.join ' '
  end
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
end

case_count = gets.chomp.to_i
case_count.times do |cc|
  buffer = gets.chomp
  STDERR.puts "#{cc+1}: #{Time.now}" if cc % 10 == 9
  ans = solve(*buffer.split.map(&:to_i))

  puts "Case ##{cc+1}:"
  puts ans
end
