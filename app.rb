#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, {adapter: "sqlite3", database: "leprosorium.db"}

class Post < ActiveRecord::Base
end

get '/' do
	erb "Leprosorium"
end

get '/new' do
	erb "New post"
end