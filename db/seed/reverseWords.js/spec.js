// name: reverseWords
// description: reverse the words in a string
describe("reverseWords", function() {

  it("'' => ''", function() {
    expect(reverseWords('')).toEqual('');
  });

  it("'foo' => 'foo'", function() {
    expect(reverseWords('foo')).toEqual('foo');
  });

  it("'foo bar baz' => 'baz bar foo'", function() {
    expect(reverseWords('foo bar baz')).toEqual('baz bar foo');
  });

});
