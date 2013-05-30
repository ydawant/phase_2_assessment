get '/user/create' do
  erb :create
end

post '/user/create' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  if user.errors.messages.length > 0
    @errors = user.errors.messages
    erb :create
  else
    redirect '/'
  end
end

get '/user/signin' do
  erb :signin
end

post '/user/signin' do
  if @user = User.authenticate(params[:user])
    session[:user_id] = @user.id
    @session = session
    redirect '/'
  else
    @errors = "Username/Password combination doesn't match records."
    erb :signin
  end
end

get '/user/signout' do
  session.clear
  redirect '/'
end

get "/user/:user_id" do
  erb :user_page
end
