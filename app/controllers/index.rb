enable :sessions
get '/' do
  if session[:user_id]
   redirect('/users/session[:user_id]')
  else
    erb :index
  end
end

get '/login' do
  erb :index
end

get '/users/profile/:user_id' do
  if session[:user_id] == params[:user_id].to_i
    @user = User.find(params[:user_id])
    erb :profile
  else
    redirect('/login')
  end
end

get '/new_user' do
  erb :new_user
end

post '/create' do
  @user = User.create(params[:user])
  p @user
  session[:user_id] = @user.id
  redirect('')
end

post '/login' do
  # params[:email], params[:password]
  @user =  User.find_by_email(params[:email])
  if @user
    if @user.password == params[:password]
      # p @user
      session[:user_id] = @user.id
      redirect('/users/profile/'+@user.id.to_s)
    else
      redirect('/login')
    end
  else
    redirect('/login')
  end
end

post '/logout' do
  session.clear
  redirect('/')
end
