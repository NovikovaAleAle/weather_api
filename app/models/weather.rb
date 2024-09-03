class Weather < ApplicationRecord

  def self.weather_historical_arr(count)
    temperature_arr = []
    Weather.limit(count).each{ |el| temperature_arr << el.temperature }
    temperature_arr
  end

  def self.weather_historical_hash(count)
    temperature_hash = {}
    Weather.limit(count).each{ |el| temperature_hash[Time.at(el.epoch_time).to_datetime] = el.temperature }
    temperature_hash
  end
end
