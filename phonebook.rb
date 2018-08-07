require 'pg'
    load './local_env.rb' if File.exist?('./local_env.rb')

def maketable()
  begin
    user_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("CREATE TABLE public.phonebookdata (
      name text,
      street_address text,
      city text,
      state text,
      zip_code text,
      phone_number text,
      email_address text)");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

def insert_info()
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("INSERT INTO public.phonebookdata (name, address, phone_number, email_address) VALUES('SAM', '1543 MAGNOLIA ST', '304-999-9999', 'samsmith6798543wv@gmail.com');");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

def update_info()
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("UPDATE public.phonebookdata
      SET name='', address='', phone_number='', email_address=''");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

def select_info()
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("SELECT name, address, phone_number, email_address
      FROM public.phonebookdata");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end

def delete_info()
  begin
    db_info = {
      host: ENV['RDS_HOST'],
      port: ENV['RDS_PORT'],
      dbname: ENV['RDS_DB_NAME'],
      user: ENV['RDS_USERNAME'],
      password: ENV['RDS_PASSWORD']
      }
    d_base = PG::Connection.new(db_info)
    d_base.exec ("DELETE FROM public.phonebookdata
      WHERE name='SAM'");
    rescue PG::Error => e
      puts e.message
    ensure
      d_base.close if d_base
  end
end
# p select_info().to_a

insert_info()
# delete_info()