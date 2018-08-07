require 'pg'
    load './local_env.rb' if File.exist?('./local_env.rb')

# def create_table()
#   begin
#     db_info = {
#       host: ENV['RDS_HOST'],
#       port: ENV['RDS_PORT'],
#       dbname: ENV['RDS_DB_NAME'],
#       user: ENV['RDS_USERNAME'],
#       password: ENV['RDS_PASSWORD']
#       }
#     d_base = PG::Connection.new(db_info)
#     d_base.exec ("CREATE TABLE public.phonebookdata (
#       first_name text,
#       last_name text,
#       street_address text,
#       city text,
#       state text,
#       zip_code text,
#       phone_number text,
#       email_address text)");
#     rescue PG::Error => e
#       puts e.message
#     ensure
#       d_base.close if d_base
#   end
# end

# def login_table()
#   begin
#     pbinfo = {
#       host: ENV['RDS_HOST'],
#       port: ENV['RDS_PORT'],
#       dbname: ENV['RDS_DB_NAME'],
#       user: ENV['RDS_USERNAME'],
#       password: ENV['RDS_PASSWORD']
#     }
# db = PG::Connection.new(pbinfo)
# db.exec ("CREATE TABLE public.login (
#           ID bigserial NOT NULL,
#           username text,
#           password text)");
#   rescue PG::Error => e
#      puts e.message
#   ensure
#   db.close if db
#   end
# end  

# def login(data)
#    pbinfo = {
#     host: ENV['RDS_HOST'],
#     port: ENV['RDS_PORT'],
#     dbname: ENV['RDS_DB_NAME'],
#     user: ENV['RDS_USERNAME'],
#     password: ENV['RDS_PASSWORD']
#   }
#   db = PG::Connection.new(pbinfo)
#   authusr = db.exec("SELECT * FROM public.login WHERE username = '#{u_n}'")
#    if authusr.num_tuples.zero? == false
#     val = authusr.values.flatten
     
#       if val.include?(password) 
#              redirect '/return'
#          else
#              msg = "Wrong Username"
#       end
#     else  
#          msg = "Wrong Password" 
#     end  
#   db.close if db

#     msg
# end 
def login(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("INSERT INTO public.login (username, password) VALUES('#{data[0]}','#{data[1]}');");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end
# login(['i love','wombats'])

def update_login(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("UPDATE public.login
      SET username='#{data[0]}', password='#{data[1]}'");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

# update_login(['i hate','wombats'])

def delete_login(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("DELETE FROM public.login
      WHERE username='#{data[0]}' AND password='#{data[1]}' ");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

# delete_login(['i hate','wombats','','','','','',''])

def insert_info(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("INSERT INTO public.phonebook (first_name, last_name, street_address, city, state, zip_code, phone_number, email_address) VALUES('#{data[0]}','#{data[1]}','#{data[2]}','#{data[3]}','#{data[4]}','#{data[5]}','#{data[6]}', '#{data[7]}');");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

# insert_info(['SAM','SMITH','15 MAIN ST','CHARLESTON','WV','25311','3049999999','sasmith98765893@gmail.com'])

def update_info(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("UPDATE public.phonebook
      SET first_name='#{data[0]}', last_name='#{data[1]}', street_address='#{data[2]}', city='#{data[3]}', state='#{data[4]}', zip_code='#{data[5]}', phone_number='#{data[6]}', email_address='#{data[7]}'");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

# update_info(['i hate','wombats','','','','','',''])

def select_info(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("SELECT first_name, last_name, street_address, city, state, zip_code, phone_number, email_address
      FROM public.phonebook");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

# select_info().to_a

def check_if_user_is_in_db(data)
  begin
    db_info = {
    host: ENV['RDS_HOST'],
    port: ENV['RDS_PORT'],
    dbname: ENV['RDS_DB_NAME'],
    user: ENV['RDS_USERNAME'],
    password: ENV['RDS_PASSWORD']
    }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("SELECT first_name, last_name, street_address, city, state, zip_code, phone_number, email_address
    FROM public.phonebook where first_name = '' and last_name = '' and street_address = '' and city = '' and state = '' and zip_code = '' and phone_number = '' and email_address = '';")
  rescue PG::Error => e
    puts e.message
    ensure
    d_base.close if d_base
  end
end

# check_if_user_is_in_db()

def delete_info(data)
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("DELETE FROM public.phonebook
      WHERE first_name='#{data[0]}' AND last_name='#{data[1]}' AND street_address='#{data[2]}' AND city='#{data[3]}' AND state='#{data[4]}' AND zip_code='#{data[5]}' AND phone_number='#{data[6]}' AND email_address='#{data[7]}'");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

# delete_info(['aaa','bbb','125 main st','chas','wv','25311','3041119999','123556aaa@gmail.com'])

# login_table()
# p select_info().to_a

# insert_info()
# delete_info()