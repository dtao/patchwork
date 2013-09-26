# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_user(user_name, real_name, email)
  User.create!({
    :user_name => user_name,
    :real_name => real_name,
    :email => email,
    :password => 'password',
    :password_confirmation => 'password'
  })
end

def create_function(user, name, description, signature)
  user.functions.create!({
    :name => name,
    :description => description,
    :signature => signature
  })
end

def add_implementation(user, function, source)
  function.implementations.create!({
    :user => user,
    :source => source
  })
end

dan = create_user('dtao', 'Dan Tao', 'daniel.tao@gmail.com')
joe = create_user('joe', 'Joe Schmoe', 'joe.schmoe@gmail.com')
jqp = create_user('jqp', 'Johnny Q. Public', 'johnny.q.public@gmail.com')

chunk = create_function dan, 'chunk', 'Split an array into N-sized chunks', <<-JAVASCRIPT
/**
 * Split an array into N-sized chunks
 *
 * @param {array} array
 * @param {number} chunkSize
 * @return {array}
 */
function chunk(array, chunkSize) {
  // Implementation goes here
}
JAVASCRIPT

add_implementation dan, chunk, <<-JAVASCRIPT
function chunk(array, chunkSize) {
  var chunks = [],
      chunk  = [];
  for (var i = 0; i < array.length; ++i) {
    chunk.push(array[i]);
    if (chunk.length === chunkSize) {
      chunks.push(chunk);
      chunk = [];
    }
  }

  if (chunk.length > 0) {
    chunks.push(chunk);
  }

  return chunks;
}
JAVASCRIPT

compare_arrays = create_function dan, 'compareArrays', 'Compare two arrays to see if they contain the same elements', <<-JAVASCRIPT
/**
 * Compare two arrays to see if they contain the same elements
 *
 * @param {array} arr1
 * @param {array} arr2
 * @return {boolean}
 */
function compareArrays(arr1, arr2) {
  // Implementation goes here
}
JAVASCRIPT

add_implementation joe, compare_arrays, <<-JAVASCRIPT
function compareArrays(arr1, arr2) {
  return arr1.join(',') === arr2.join(',');
}
JAVASCRIPT

add_implementation dan, compare_arrays, <<-JAVASCRIPT
function compareArrays(arr1, arr2) {
  if (arr1.length !== arr2.length) {
    return false;
  }

  for (var i = 0; i < arr1.length; ++i) {
    if (arr1[i] !== arr2[i]) {
      return false;
    }
  }

  return true;
}
JAVASCRIPT
