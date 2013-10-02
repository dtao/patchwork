describe('chunk', function() {
  it('has no effect on an empty array', function() {
    expect(chunk([], 3)).toEqual([]);
  });

  it('does not modify the array in-place', function() {
    var array = [1, 2, 3];
    chunk(array, 2);
    expect(array).toEqual([1, 2, 3]);
  });

  it('splits an array into chunks of the specified size', function() {
    expect(chunk([1, 2, 3, 4], 2)).toEqual([[1, 2], [3, 4]]);
  });

  it('includes a partial final chunk, if necessary', function() {
    expect(chunk([1, 2, 3], 2)).toEqual([[1, 2], [3]]);
  });
});
