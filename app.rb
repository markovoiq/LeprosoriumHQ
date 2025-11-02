#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, {adapter: "sqlite3", database: "leprosorium.db"}

class Post < ActiveRecord::Base
	validates :content, { presence: true, length: { minimum: 1 } }
end

get '/' do
	erb "Leprosorium"
end

get '/new' do
	erb :new
end

post '/new' do

	@post = Post.new params[:post]

	if @post.save
		erb "The post has been published"
	else
		@error = @post.errors.full_messages.first
		erb :new
	end

end