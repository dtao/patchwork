# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

require 'yaml'

def create_user(user_name, real_name, email)
  User.create!({
    :user_name => user_name,
    :real_name => real_name,
    :email => email,
    :password => 'password',
    :password_confirmation => 'password'
  })
end

def random_user
  @users ||= User.all
  @users[rand(@users.length)]
end

def path(relative)
  File.join(File.dirname(__FILE__), *relative.split('/'))
end

def extension_for_language(lang)
  case lang
  when 'javascript' then return 'js'
  when 'ruby' then return 'rb'
  else raise 'WTF?'
  end
end

create_user('dtao', 'Dan Tao', 'daniel.tao@gmail.com')
create_user('joe', 'Joe Schmoe', 'joe.schmoe@gmail.com')
create_user('jqp', 'Johnny Q. Public', 'johnny.q.public@gmail.com')

Dir[path('seeds/*/*')].each do |dir|
  name  = File.basename(dir)
  lang  = File.basename(File.dirname(dir))
  ext   = extension_for_language(lang)
  info  = YAML.load_file(File.join(dir, "#{name}.yml"))
  tests = File.read(File.join(dir, "tests.#{ext}"))

  func = random_user.functions.create!({
    :name        => name,
    :description => info['description'],
    :language    => lang,
    :tests       => tests
  })

  puts "Created function '#{func.name}'."

  Dir["#{dir}/#{name}*.#{ext}"].each do |impl|
    source = File.read(impl)

    user = random_user
    user.implementations.create!({
      :function => func,
      :source   => source
    })

    puts "Created implementation '#{name}/#{user.user_name}'."
  end
end
