require 'byebug'

def day_1
  datas = File.read("#{__dir__}/day1-input.txt")
  datas.split(/\n/).size # 200
  puts xx.map{|x| xx.include?(2020 - x) ? [:yes, x, 2020 - x] : false }
  # looked left over numbers from puts output with my eyes ;)
  puts 706 * 1314 # manual, yes 927684
  puts xx.map{|y| xx.map{|x| xx.include?(2020 - y - x) ? [:yes, x, y,  2020 - y - x] : nil }.compact  }
  puts 677*532*811 # 292093004
end

class PasswordPolicy
  def initialize(policy_string)
    @minmax, @char = policy_string.split(/ /)
    @min, @max = @minmax.split(/-/).map(&:to_i)
  end

  def validate_password(string)
    present_char_count = string.gsub(/[^#{@char}]/, '').length
    present_char_count >= @min && present_char_count <= @max
  end

  def validate_password2(string)
    (string[@min-1] == @char) ^ (string[@max-1] == @char)
  end
end

class PasswordLine
  def initialize(line)
    blocks = line.split(/: /)
    @password_policy = PasswordPolicy.new(blocks.first)
    @password_string = blocks.last
  end

  def valid?
    @password_policy.validate_password(@password_string)
  end

  def valid_policy2?
    @password_policy.validate_password2(@password_string)
  end
end

def day_2
  datas = File.read("#{__dir__}/day2-input.txt").split(/\n/)
  puts datas.select{|line| PasswordLine.new(line).valid?}.size
end

def day_2q2
  datas = File.read("#{__dir__}/day2-input.txt").split(/\n/)
  puts datas.select{|line| PasswordLine.new(line).valid_policy2?}.size
end

# On day 3, he shall sleep under a tree

def day_4
  passports = File.read("#{__dir__}/day4-input.txt").split(/\n\n/)
  puts passports.select { |pass|
    #debugger
    dataline = pass.split(/[ \n]/).map{|pair| pair.split(/:/) }.to_h
    dataline.delete("byr") unless (1920..2002).include? dataline["byr"].to_i
    dataline.delete("iyr") unless (2010..2020).include? dataline["iyr"].to_i
    dataline.delete("eyr") unless (2020..2030).include? dataline["eyr"].to_i
    if res = dataline["hgt"]&.match(/([0-9]+)cm$/)
      dataline.delete("hgt") unless (150..193).include? res[1].to_i
    elsif res = dataline["hgt"]&.match(/([0-9]+)in$/)
      dataline.delete("hgt") unless (59..76).include? res[1].to_i
    else
      dataline.delete("hgt")
    end
    dataline.delete("hcl") unless dataline["hcl"]&.match(/\A#[0-9a-f]{6}\Z/i)
    valid_eye_color = %w[amb blu brn gry grn hzl oth]
    dataline.delete("ecl") unless valid_eye_color.include?(dataline["ecl"])
    dataline.delete("pid") unless dataline["pid"]&.match(/\A[0-9]{9}\Z/)
    (dataline.keys.sort - ["cid"]) == ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
  }.size
end

day_4