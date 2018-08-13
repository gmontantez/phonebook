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
  session[:username] = params[:username]
  session[:password] = params[:password]
  erb :sign_in
end

post '/create_user' do
  session[:username] = params[:username]
  session[:password] = params[:password]
  redirect '/sign_in'
end

post '/sign_in' do
  redirect '/input_info'
end

get '/input_info' do
  erb :input_info
end

post '/input_info' do
  session[:data] = params[:data]
  db_check = check_if_user_is_in_db(session[:data])
  if db_check.num_tuples.zero? == true 
    puts "not in db"
    insert_info(session[:data])
    redirect '/final_result'
  else
    puts "it is in the db, update your listing"
    redirect '/updates'
  end
end

get '/updates' do
  db_check = check_if_user_is_in_db(session[:data]).values[0]
  erb :updates, locals: {db_check: db_check}
end

post '/updates' do
  session[:newdata] = params[:data]
  update_info(session[:newdata], session[:data]) 
  redirect '/final_result'
end

post '/deletes' do
  delete_info(check_if_user_is_in_db(session[:data]).values[0])
  redirect '/final_result'
end

get '/final_result' do
  db_return = select_info()
  erb :final_result, locals: {db_return: db_return}
end

post '/final_result' do
  redirect '/input_info'
end
