require 'rufus-scheduler'
require 'dotenv/load'
require 'rest-client'
require 'json'

require_relative 'db_connection'

weathers = DB[:weathers]

scheduler = Rufus::Scheduler.new

@url = 'http://dataservice.accuweather.com/currentconditions/v1/294021'
@headers = {params: {apikey: ENV['API_KEY']}}

scheduler.every '1h' do

  res = RestClient.get(@url, @headers)
  res_body = JSON.parse(res)[0]
  temperature = res_body['Temperature']['Metric']['Value']
  puts temperature
  weathers.insert(temperature: temperature, epoch_time: el['EpochTime'], created_at: DateTime.now, updated_at: DateTime.now)
end

scheduler.join