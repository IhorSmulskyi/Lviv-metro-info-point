require 'yaml'

class MetroInfopoint
  def initialize(path_to_timing_file:, path_to_lines_file:)
    @timing_data = YAML.load_file(path_to_timing_file)['timing']
    @lines_data = YAML.load_file(path_to_lines_file)
  end

  def calculate(from_station:, to_station:)
    { price: calculate_price(from_station: from_station, to_station: to_station) }
    { time: calculate_time(from_station: from_station, to_station: to_station) }
  end

  def calculate_price(from_station:, to_station:)
    start = @timing_data.index(@timing_data.find { |e| e['start'].to_s == from_station })
    finish = @timing_data.index(@timing_data.find { |e| e['start'].to_s == to_station })
    array_of_station = []
    if start > finish
      @timing_data[start...finish].each { |i| array_of_station.push(i['price']) }
    elsif start < finish
      @timing_data[start...finish].reverse_each { |i| array_of_station.push(i['price']) }
    end
    puts "Price your trip #{array_of_station.sum}"
  end

  def calculate_time(from_station:, to_station:)
    start = @timing_data.index(@timing_data.find { |e| e['start'].to_s == from_station })
    finish = @timing_data.index(@timing_data.find { |e| e['start'].to_s == to_station })
    array_of_station = []
    if start > finish
      @timing_data[start...finish].each { |i| array_of_station.push(i['time']) }
    elsif start < finish
      @timing_data[start...finish].reverse_each { |i| array_of_station.push(i['time']) }
    end
    puts "Time your trip #{array_of_station.sum}"
  end
end

info = MetroInfopoint.new(path_to_timing_file: './config/timing1.yml', path_to_lines_file: './config/config.yml')
info.calculate(from_station: 'nezalezhna', to_station: 'shevchenkivska')
