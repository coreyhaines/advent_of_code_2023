# 54597
File
.open("input.txt", "r")
.map { _1.scan(/\d/) }
.map { (_1[0] + _1[-1]).to_i }
.sum
.yield_self { puts _1 }
