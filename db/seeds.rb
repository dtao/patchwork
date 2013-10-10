require 'yaml'

USERS = YAML.load_file('config/users.yml').map do |name, details|
  User.create!({
    :name                  => name,
    :email                 => details['email'],
    :password              => details['password'],
    :password_confirmation => details['password']
  })
end

def random_user
  USERS[rand() * USERS.size]
end

LANGUAGES_BY_EXTENSION = {
  '.js' => 'javascript',
  '.rb' => 'ruby'
}

Dir['db/seed/*'].each do |folder|
  extension = File.extname(folder)
  language  = LANGUAGES_BY_EXTENSION[extension]
  spec      = File.read(File.join(folder, "spec#{extension}"))

  name, description, *tests = spec.lines
  name        = name.match(/\/\/ name: (.*)/)[1]
  description = description.match(/\/\/ description: (.*)/)[1]
  tests       = tests.join()

  patch = random_user.patches.create!({
    :name        => name,
    :language    => language,
    :description => description,
    :tests       => tests
  })

  puts "Created patch '#{patch.name}'."

  Dir[File.join(folder, '*')].grep(/\d+#{extension}$/).each do |implementation_file|
    source = File.read(implementation_file)

    impl = random_user.implementations.create!({
      :patch  => patch,
      :source => source
    })

    puts "Created implementation '#{impl.label}'."
  end
end
