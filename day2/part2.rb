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

def find_max_color_counts(game)
  game.tap do
    _1[:needed_color_counts] = _1[:rounds][1..].each_with_object(_1[:rounds].first) do |round, max_counts|
      CUBE_COUNTS.keys.each do |color|
        if round.key?(color) && round[color].to_i > max_counts[color].to_i
          max_counts[color] = round[color]
        end
      end
    end
  end
end

def calculate_power(game)
  game.tap do
    _1[:power] = _1[:needed_color_counts].values.map(&:to_i).inject(:*)
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
  .map { find_max_color_counts _1 }
  .map { p _1 }
  .map { calculate_power _1 }
  .map { p _1 }
  .map { _1[:power] }
  .map { p _1 }
  .inject(:+)
  .yield_self { p "ANSWER: #{_1}" }
# 86036
