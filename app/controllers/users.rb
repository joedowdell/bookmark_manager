get '/users/new' do
  @user = User.new 
  erb :"users/new"
end

post '/users' do 
  @user = User.create(:email => params[:email],
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new"
  end

end

get '/users/reset_password/:token' do
  puts request.url
  @user = User.first(:password_token => params[:token])
  erb :"users/reset_password/:token"
end

post '/users/reset_password/:token' do 
  "Hello World"
end



