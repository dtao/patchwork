// name: repeat
// description: repeat a string N times
describe("repeat", function() {

  it("'a', 3 => 'aaa'", function() {
    expect(repeat('a', 3)).toEqual('aaa');
  });

  it("'foo', 3 => 'foofoofoo'", function() {
    expect(repeat('foo', 3)).toEqual('foofoofoo');
  });

  it("'', 100 => ''", function() {
    expect(repeat('', 100)).toEqual('');
  });

  it("'1', 5 => '11111'", function() {
    expect(repeat('1', 5)).toEqual('11111');
  });

  it("'abc', 0 => ''", function() {
    expect(repeat('abc', 0)).toEqual('');
  });

});
