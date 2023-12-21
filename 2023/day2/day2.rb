require 'debug'

MaxCubes = {
    red: 12,
    green: 13,
    blue: 14,
}

puts 0x2D

data = {}
result = File.read('input.txt').split("\n").map do |line|
    game_id, bags = line.split(':')
    next if bags.nil?

    data[game_id] = {}
    #data[game_id][:status] = :possible

    bags.split(/; */).each do |play|
        play.split(/, */).each do |turns|

            cnt, color = turns.split(' ')
            data[game_id][color] ||= 0
            data[game_id][color] = cnt.to_i if cnt.to_i > data[game_id][color]

            #if cnt.to_i > MaxCubes[color.to_sym]
            #    data[game_id][:status] = :impossible
            #    break
            #end
        end

        #break if data[game_id][:status] == :impossible
    end
    power = data[game_id].inject(1) { |sum, (k, v)| sum * v}
    puts power
    power
end

puts result.sum
#puts data.select{ |k, v| v[:status] != :possible }.inspect
#puts data.select{ |k, v| v[:status] == :possible }.keys.sum { _1.gsub('Game', '').to_i }