CUBE_COUNTS = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

def parse_game_id(game)
  game.tap do
    _1[:game_id] = _1[:game_id].split(" ")[1]
  end
end

def parse_rounds(game)
  game.tap do
    _1[:rounds] = _1[:rounds].split(";").map { |r| r.split(",").map(&:strip) }
  end
end

def parse_draws(game)
  game.tap do
    _1[:rounds] = _1[:rounds].map do |round|
      round.map do |draw|
        draw.split(" ").rotate
      end.to_h
    end
  end
end

def valid_rounds?(game)
  game[:rounds].none? do |round|
    CUBE_COUNTS.keys.any? do |color|
      round[color].to_i > CUBE_COUNTS[color].to_i
    end
  end
end

File
  .open("input.txt", "r")
  .lazy
  .map { p _1 }
  .map { _1.split(":") }
  .map { p _1 }
  .map { {game_id: _1[0], rounds: _1[1]} }
  .map { p _1 }
  .map { parse_game_id _1 }
  .map { p _1 }
  .map { parse_rounds _1 }
  .map { p _1 }
  .map { parse_draws _1 }
  .map { p _1 }
  .filter { valid_rounds? _1 }
  .map { _1[:game_id].to_i }
  .map { p _1 }
  .inject(:+)
  .yield_self { p "ANSWER: #{_1}" }
# 2600
