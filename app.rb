#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, {adapter: "sqlite3", database: "leprosorium.db"}

class Post < ActiveRecord::Base
	validates :title, { presence: true, length: { minimum: 1 } }
	validates :content, { presence: true, length: { minimum: 5 } }

	has_many :comments
end

class Comment < ActiveRecord::Base
	validates :content, { presence: true, length: { minimum: 5 } }

	belongs_to :post
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

get '/details/:id' do

  @post = Post.find(params[:id])
  @comments = @post.comments
  erb :details

end

post '/details/:id/comments' do

  post = Post.find(params[:id])
  post.comments.create(content: params[:content])
  redirect "/details/#{post.id}"
  
end
