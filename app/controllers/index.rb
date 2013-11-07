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

get '/create' do
  if logged_in?
    erb :create
  else
    erb :login, :layout => false, :locals => {:@errors => ["Must be logged in to access that feature"]}
  end
end

post '/posts' do
  user_id = current_user.id
  post = Post.create(user_id: user_id, title: params[:title], url: params[:url], text: params[:text])

  if post
    if params[:url]
      redirect to('/')
    else
      Post.update(post.id, :url => "/posts/#{post.id}")
      redirect to('/')
    end
  else
    @errors = post.errors.full_messages
    erb :create
  end
end
