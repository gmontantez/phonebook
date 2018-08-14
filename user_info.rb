require 'bcrypt'
    load './local_env.rb' if File.exist?('./local_env.rb')

#   name = params[:name]
#   newuser = params[:newuser]
#   newpass = params[:newpass]
#   newemail = params[:newemail]
#   role = params[:role]
#   industry = params[:industry]

#   db = connection()
#   encrypted_pass = BCrypt::Password.create(newpass, :cost => 11)
#   checkUser = db.exec("SELECT username FROM users WHERE username = '#{newuser}'")

#   if checkUser.num_tuples.zero? == true
#     db.exec ("INSERT INTO users (name, username, password,email, role, industry) VALUES ('#{name}','#{newuser}','#{encrypted_pass}','#{newemail}','#{role}', '#{industry}')")
#     redirect "/admin?message=User '#{name}' has been added"
#   else
#     db.close
#     redirect '/admin?message=User Already Exists'
#   end

# end

def hash_password(password)
  BCrypt::Password.create(password).to_s
end

def test_password(password, hash)
  BCrypt::Password.new(hash) == password
end

def current_user
  if session[:user_id]
    USERS.find { |u| u.id == session[:user_id] }
  else
    nil
  end
end

