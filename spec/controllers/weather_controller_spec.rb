require 'rails_helper'

RSpec.describe WeatherController do

  before(:all) do
    temperature_arr = [17.0, 23.0, 23.6, 23.9, 24.0, 24.5, 25.0, 25.9, 25.8, 27.0,17.0, 23.0, 23.6, 23.9, 24.0, 24.5, 25.0, 25.9, 25.8, 27.0, 30.6, 12.4, 17.8, 30.0]
    i = 0
    24.times do
      Weather.create(temperature: temperature_arr[i], epoch_time: DateTime.now + i.hour)
      i += 1
    end
  end

  describe 'GET #current' do
    it 'returns the current temperature' do
      allow_any_instance_of(RestDbApi).to receive(:call).and_return([{ 'Temperature' => { 'Metric' => { 'Value' => 25 } } }])

      get :current

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'Current temperature' => 25 })
    end
  end

  describe 'GET #historical' do
    it 'returns historical weather data' do
      get :historical

      expect(response.headers['Content-Type']).to include('application/json')
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to be_a(Hash)
      expect(JSON.parse(response.body).keys.length).to eq(24)
    end
  end

  describe 'GET #historical_max' do

    it 'returns the maximum historical temperature' do
      get :historical_max

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'temperature_max' => 30.6 })
    end
  end

  describe 'GET #historical_min' do

    it 'returns the minimum historical temperature' do
      get :historical_min

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'temperature_min' => 12.4 })
    end
  end

  describe 'GET #historical_avg' do

    it 'returns the average historical temperature' do
      get :historical_avg

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'temperature_avg' => 23.8})
    end
  end

  describe 'GET #by_time' do
    let(:timestamp) { (DateTime.now + 35.minute).to_i }

    it 'returns the temperature by time' do
      get :by_time, params: { timestamp: timestamp }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'temperature_by_time' => 23.0 } )
    end

    it 'returns not found if timestamp is out of range' do
      get :by_time, params: { timestamp: 1609458000 } # Out of range timestamp

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Not found' })
    end
  end

  after(:all) do
    Weather.delete_all
  end
end
