require 'debug'

MaxCubes = {
    red: 12,
    green: 13,
    blue: 14,
}

data = {}
File.read('input.txt').split("\n").map do |line|
    game_id, bags = line.split(':')
    next if bags.nil?

    bags.split(/[,;]/).map do |play|
        cnt, color = play.split(' ')
        data[game_id] ||= {}
        data[game_id][color.to_sym] ||= 0
        data[game_id][color.to_sym] += cnt.to_i
    end

    data[game_id][:status] = :possible
    MaxCubes.keys.map do |color|
        if data[game_id][color] && data[game_id][color] > MaxCubes[color]
            data[game_id][:status] = :impossible
            break
        end
    end
end

puts data.select{ |k, v| v[:status] != :possible }.inspect
puts data.select{ |k, v| v[:status] == :possible }.keys.sum { _1.gsub('Game', '').to_i }