class WeatherController < ApplicationController
  before_action :set_count, only: [:historical, :historical_max, :historical_min, :historical_avg]

  def current
    rdb = RestDbApi.new('http://dataservice.accuweather.com/currentconditions/v1/294021')
    res_body = rdb.call[0]
    @temperature = res_body['Temperature']['Metric']['Value']
    render json: {'Current temperature' => @temperature}
  end

  def historical
    render json: Weather.weather_historical_hash(@count)
  end

  def historical_max
    render json: {temperature_max: Weather.weather_historical_arr(@count).max}
  end

  def historical_min
    render json: {temperature_min: Weather.weather_historical_arr(@count).min}
  end

  def historical_avg
    weather_arr = Weather.weather_historical_arr(@count)
    weather_avg = weather_arr.inject{|sum,el| sum + el}/@count
    render json: {temperature_avg: weather_avg.round(1)}
  end

  def by_time
    timestamp = params[:timestamp].to_i

    @weather = Weather.order(epoch_time: :asc)
    if (@weather.first.epoch_time - 4000) < timestamp && (@weather.last.epoch_time + 4000) > timestamp
      time_after = @weather.find_by("epoch_time >= ?", timestamp) || time_after = @weather.last
      time_before = @weather.find_by("epoch_time < ?", timestamp) || time_before = @weather.first
      if (timestamp - time_before.epoch_time) < (time_after.epoch_time - timestamp)
        render json: {temperature_by_time: time_before.temperature}
      else
        render json: {temperature_by_time: time_after.temperature}
      end
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  private
    def set_count
      @count = 24
    end
end
