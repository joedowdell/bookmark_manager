env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './app/models/link'
require './app/models/tag'
require './app/models/user'

DataMapper.finalize
