require 'rails_helper'

RSpec.describe Weather, type: :model do
  before(:all) do
    temperature_arr = [17.0, 23.0, 23.6, 23.9, 24.0]
    i = 0
    5.times do
      Weather.create(temperature: temperature_arr[i], epoch_time: DateTime.now + i.hour)
      i += 1
    end
  end

  describe '.weather_historical_arr' do

    it 'returns an array of temperatures' do
      result = Weather.weather_historical_arr(5)
      expect(result).to eq([17.0, 23.0, 23.6, 23.9, 24.0])
    end

    it 'returns the correct number of temperatures' do
      result = Weather.weather_historical_arr(3)
      expect(result.length).to eq(3)
    end
  end

  describe '.weather_historical_hash' do

    it 'returns a hash of epoch_time to temperature' do
      result = Weather.weather_historical_hash(2)
      @time1 = Time.at((DateTime.now + 3.hour).to_i).to_datetime
      @time2 = Time.at((DateTime.now + 4.hour).to_i).to_datetime
      expect(result).to eq({
          @time1 => 23.9,
          @time2 => 24.0
      })
    end

    it 'returns the correct number of entries' do
        result = Weather.weather_historical_hash(2)
        expect(result.keys.length).to eq(2)
    end
  end

  after(:all) do
      Weather.delete_all
  end
end
