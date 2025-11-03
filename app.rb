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

	@posts = Post.order("id DESC")

	erb :posts
	
end

get '/new' do
	erb :new
end

post '/new' do

	@post = Post.new params[:post]

	if @post.save
		redirect to '/'
	else
		@error = @post.errors.full_messages.first
		erb :new
	end

end