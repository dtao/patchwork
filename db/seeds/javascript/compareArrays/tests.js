describe('compareArrays', function() {
  it('compares two empty arrays as equal', function() {
    expect(compareArrays([], [])).toBe(true);
  });

  it('compares arrays with the same elements in the same order as equal', function() {
    var arr1 = [1, 2, 3];
    var arr2 = [1, 2, 3];
    expect(compareArrays(arr1, arr2)).toBe(true);
  });

  it('compares arrays with different elements as unequal', function() {
    var arr1 = [1, 2, 3];
    var arr2 = [4, 5, 6];
    expect(compareArrays(arr1, arr2)).toBe(false);
  });

  it('compares arrays with the same elements in a different order as unequal', function() {
    var arr1 = [1, 2, 3];
    var arr2 = [1, 3, 2];
    expect(compareArrays(arr1, arr2)).toBe(false);
  });

  it('performs a deep comparison (works on nested arrays)', function() {
    var arr1 = [1, [2, [3]]];
    var arr2 = [1, [2, [3]]];
    expect(compareArrays(arr1, arr2)).toBe(true);
  });
});
