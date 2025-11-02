#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


set :database, {adapter: "sqlite3", database: "leprosorium.db"}

get '/' do
	erb "Leprosorium"
end