# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

rdb = RestDbApi.new('http://dataservice.accuweather.com/currentconditions/v1/294021/historical/24')
res_body = rdb.call

res_body.reverse_each do |el|
  Weather.create(temperature: el['Temperature']['Metric']['Value'], epoch_time: el['EpochTime'])
end

