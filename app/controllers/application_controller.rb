
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
  #This is like the home page of a website
  get '/articles' do
    @articles = Article.all
    # binding.pry
    erb :index
  end
#--------------------------------------------------------------------------------------------------
  #This is will prompt/collect info from the developer for a new path. ***AKA new
  get '/articles/new' do
    @article = Article.new
    erb :new
  end
#--------------------------------------------------------------------------------------------------
  #This builds the new path. ***AKA create
  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
     # user_input = params
    # @article = Article.create(user_input)
    # binding.pry
    redirect to "/articles/#{ @article.id }"
  end
#--------------------------------------------------------------------------------------------------
  #This shows the new path. ***AKA show
  get '/articles/:id' do
    # id = params[:id]
    @article = Article.find(params[:id])
    erb :show
  end
#--------------------------------------------------------------------------------------------------
  #This allows user to edit the already built path. ***AKA edit
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end
#--------------------------------------------------------------------------------------------------
#This shows the newly updated path ***AKA update
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"

  end
#--------------------------------------------------------------------------------------------------
#This allows path to be deleted *** AKA delete
  delete '/articles/:id' do
    Article.delete(params[:id])
    redirect to "/articles"
  end


end
 