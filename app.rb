require 'sinatra'
require_relative 'dbfunctions.rb'
require_relative 'user_info.rb'
enable :sessions

User = Struct.new(:id, :username, :password_hash)
USERS = [
 User.new(1, 'ice', hash_password('cream')),
 User.new(2, 'brownie', hash_password('bites')),
]

get '/' do
  erb :welcome_page
end

post '/welcome_page' do
  redirect '/sign_in'
end

get '/sign_in' do
  session[:username] = params[:username]
  session[:password] = params[:password]
  message = params[:message] || ""
  erb :sign_in, locals: {message: message, username: session[:username], password: session[:password]}
end

post '/create_user' do
  session[:username] = params[:username]
  session[:password] = params[:password]
  db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
  d_base = PG::Connection.new(db_info)
  encrypted_pass = BCrypt::Password.create(session[:password], :cost => 11)
  checkUser = d_base.exec("SELECT username FROM login WHERE username = '#{session[:username]}'")
   if checkUser.num_tuples.zero? == true
    d_base.exec ("INSERT INTO login (username, password) VALUES ('#{session[:username]}','#{encrypted_pass}')")
    redirect '/input_info'
  else
    d_base.close
    redirect '/sign_in?message=UserName Already Exists'
  end
end

post '/sign_in' do
  session[:username] = params[:username]
  session[:password] = params[:password]
  db_info = {
   host: ENV['RDS_HOST'],
   port: ENV['RDS_PORT'],
   dbname: ENV['RDS_DB_NAME'],
   user: ENV['RDS_USERNAME'],
   password: ENV['RDS_PASSWORD']
  }
  d_base = PG::Connection.new(db_info)
    user_name = session[:username]
    user_pass = session[:password]
    match_login = d_base.exec("SELECT username, password FROM login WHERE username = '#{session[:username]}'")
        if match_login.num_tuples.zero? == true
          error = erb :sign_in,locals: {message:"Invalid UserName and Password Combination"}
          return error
        end
    password = match_login[0]['password']
    comparePassword = BCrypt::Password.new(password)
    usertype = match_login[0]['usertype']
      if match_login[0]['username'] == user_name &&  comparePassword ==    user_pass
      session[:username] = user_name
      erb :input_info, locals: {username: session[:username]}
      else
      erb :sign_in,locals: {message:"Invalid UserName and Password Combination"}
      end
end

get '/input_info' do
  erb :input_info, locals: {username: session[:username]}
end

post '/input_info' do
  session[:data] = params[:data]
  db_check = check_if_user_is_in_db(session[:data],session[:username])
  if db_check.num_tuples.zero? == true 
    insert_info(session[:data],session[:username])
    redirect '/final_result'
  else
    redirect '/updates'
  end
end

post '/final_page' do
  redirect '/final_result'
end

get '/updates' do
  db_check = check_if_user_is_in_db(session[:data],session[:username]).values[0]
  erb :updates, locals: {db_check: db_check, username: session[:username]}
end

post '/updates' do
  session[:newdata] = params[:data]


  update_info(session[:newdata], session[:data], session[:username]) 
  redirect '/final_result'
end

post '/deletes' do
  delete_info(check_if_user_is_in_db(session[:data], session[:username]).values[0], session[:username])
  redirect '/final_result'
end

get '/final_result' do
  db_return = select_info(session[:username])
  erb :final_result, locals: {db_return: db_return, username: session[:username]}
end

post '/final_result' do
  redirect '/input_info'
end
