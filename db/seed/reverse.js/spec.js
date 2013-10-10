// name: reverse
// description: reverse the characters in a string
describe("reverse", function() {

  it("'' => ''", function() {
    expect(reverse('')).toEqual('');
  });

  it("'foo' => 'oof'", function() {
    expect(reverse('foo')).toEqual('oof');
  });

  it("'hello!' => '!olleh'", function() {
    expect(reverse('hello!')).toEqual('!olleh');
  });

});
