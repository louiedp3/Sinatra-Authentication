

get '/' do
  # render home page
 #TODO: Show all users if user is signed in
 	@users=User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  # sign-in
   @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
    	session[:id]=@user.id	
      redirect '/'
    else
      redirect '/sessions/new'
    end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  session.clear
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  # sign-up a new user
  new_user = User.create(:name => params[:user][:name], :email => params[:user][:email], :password => params[:user][:password])
  session[:id] = new_user.id
  redirect '/'
end
