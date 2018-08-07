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
  puts "this is sessionnew username #{session[:username]}"
  puts "this is sessionnew password #{session[:password]}"
    redirect '/sign_in'
end

post '/sign_in' do
  puts "this is sessionnew username post sign_in #{session[:username]}"
  puts "this is sessionnew password username post sign_in #{session[:password]}"
  redirect '/input_info'
end

get '/input_info' do
  erb :input_info
end

post '/input_info' do
  data = params[:data]
 
  # db_return = select_info()
  db_check = check_if_user_is_in_db(data)
  if db_check.num_tuples.zero? == true 
    puts "not in db"
    insert_info(data)
    redirect '/final_result'
  else
    db_check
    puts "it is in the db, input a different listing"
    redirect '/insert_info'
  end
   # insert_info(data)
end

get '/final_result' do
  data = params[:data]
  db_return = select_info(data)
  db_check = check_if_user_is_in_db(data)
  erb :final_result, locals: {db_return: db_return, db_check: db_check}
end

post '/final_result' do
  redirect '/input_info'
end

