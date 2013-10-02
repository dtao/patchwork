describe('reverseString', function() {
  it('has no effect on the empty string', function() {
    expect(reverseString('')).toEqual('');
  });

  it('reverses the characters in a string', function() {
    expect(reverseString('hello')).toEqual('olleh');
  });

  it('does not modify the string in-place (as if that were even possible in JavaScript)', function() {
    var foo = 'foo';
    reverseString(foo);
    expect(foo).toEqual('foo');
  });
});
