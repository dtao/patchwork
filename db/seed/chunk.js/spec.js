// name: chunk
// description: split an array into N-sized chunks
describe("chunk", function() {

  it("[], 2 => []", function() {
    expect(chunk([], 2)).toEqual([]);
  });

  it("[1, 2], 1 => [[1], [2]]", function() {
    expect(chunk([1, 2], 1)).toEqual([[1], [2]]);
  });

  it("[1, 2, 3], 2 => [[1, 2], [3]]", function() {
    expect(chunk([1, 2, 3], 2)).toEqual([[1, 2], [3]]);
  });

  it("[1, 2, 3], 4 => [[1, 2, 3]]", function() {
    expect(chunk([1, 2, 3], 4)).toEqual([[1, 2, 3]]);
  });

});
