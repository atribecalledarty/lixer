class VideoPostsController < ApplicationController
  get '/video-posts' do
    if logged_in? 
      @user = current_user
    end
    
    erb :'video_posts/video_posts'
  end
  
  get '/video-posts/new' do
    if logged_in?
      erb :'video_posts/new'
    else
      redirect '/login'
    end
  end
  
  post '/video-posts' do
    if params["title"] == "" || params["video_link"] == ""
      flash[:message] = "Please enter a title and video link."
      redirect '/video-posts/new'
    end
    
    user = current_user
    videopost = VideoPost.create(params)
    videopost.creator = user
    videopost.save
    redirect "/video-posts/#{videopost.id}"
  end
  
  get '/video-posts/:id' do
    @videopost = VideoPost.find(params[:id])
    
    erb :'video_posts/show'
  end
  
  post '/video-posts/:id/delete' do
    user = current_user
    user.created_video_posts.destroy(VideoPost.find(params[:id]))
    user.save
    
    flash[:message] = "Successfully deleted video"
    redirect '/video-posts'
  end
  
  post '/video-posts/:id/like' do
    user = current_user
    videopost = VideoPost.find(params[:id])
    user.liked_video_posts << videopost
    user.save
    
    flash[:message] = "Successfully liked '#{videopost.title}'"
    redirect '/video-posts'
  end
  
  get '/video-posts/:id/edit' do
    @video = VideoPost.find(params[:id])
    
    erb :'video_posts/edit'
  end
  
  post '/video-posts/:id' do
    @videopost = VideoPost.find(params[:id])
    if params["title"] == "" && params["video_link"] == ""
      flash[:message] = "Please fill in at least one thing to edit"
      
      redirect "/video-posts/#{@videopost.id}/edit"
    end
  end
end