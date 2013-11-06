# Show all posts
get '/' do
  @posts = Post.all
  erb :index
end

# Show newest posts
get '/newest' do
  @posts = Post.all
  @posts.sort_by! { |post| Time.now - post.created_at }
  erb :index
end

# Show comments for a post
get '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  @comments = @post.comments

  erb :comments
end

# Show user profile
get '/users/:user_id' do
  @user = User.find(params[:user_id])

  erb :user
end

# Show user's posts
get '/users/:user_id/posts' do
  @user = User.find(params[:user_id])
  @posts = @user.posts

  erb :index
end

# Show user's comments
get '/users/:user_id/comments' do
  @user = User.find(params[:user_id])
  @comments = @user.comments

  erb :comments
end

get '/login' do
  erb :login, :layout => false
end

post '/login' do
  username = params[:user][:username]
  password = params[:user][:password]

  if User.exists?(username)
    user = User.authenticate(username, password)
    if user
      send(:current_user=, user)
      redirect to('/')
    else
      @errors = ["Password incorrect, please try again"]
      erb :login, :layout => false
    end
  else
    @errors = ["Username doesn't exist, please create an account"]
    erb :login, :layout => false
  end
end

get '/logout' do
  logout
  redirect to('/')
end

post '/register' do
  user = User.new(params[:user])

  if user.valid?
    user.save
    redirect to('/login')
  else
    @errors = user.errors.full_messages
    erb :login, :layout => false
  end

end
