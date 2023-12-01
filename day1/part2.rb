# 54504
NUMBERS = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}
MATCH_REGEX = Regexp.new NUMBERS.keys.append("\\d").join("|")
File
.open("input.txt", "r")
.lazy
.map { p _1 }
.map { [_1.partition(MATCH_REGEX), _1.rpartition(MATCH_REGEX)] }
.map { p _1 }
.map { [_1[0][1], _1[-1][1]] }
.map { p _1 }
.map { [NUMBERS.fetch(_1[0], _1[0]).to_s, NUMBERS.fetch(_1[1], _1[1]).to_s] }
.map { p _1 }
.map(&:join)
.map { p _1 }
.map(&:to_i)
.map { p _1 }
.inject(:+)
.yield_self { p _1 }
