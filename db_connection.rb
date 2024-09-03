require 'sequel'

DB = Sequel.connect(
  adapter: 'sqlite',
  database: 'db/development.sqlite3'
)