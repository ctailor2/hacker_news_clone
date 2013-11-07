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
