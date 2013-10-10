// name: sortByKeys
// description: sort an array by multiple keys
describe("sortByKeys", function() {
  var patients = [
    {name: 'John', roomNumber: 1, bedNumber: 1},
    {name: 'Lisa', roomNumber: 1, bedNumber: 2},
    {name: 'Chris', roomNumber: 2, bedNumber: 1},
    {name: 'Omar', roomNumber: 3, bedNumber: 1}
  ];
  
  it("sorts a sequence by a given key", function() {
    var sorted = sortByKeys(patients, ["name"]);
    expect(map(sorted, "name")).toEqual([
      'Chris', 'John', 'Lisa', 'Omar'
    ]);
  });
  
  it("can sort a sequence by two keys", function() {
    var sorted = sortByKeys(patients, ["roomNumber", "name"]);
    expect(map(sorted, "name")).toEqual([
      'John', 'Lisa', 'Chris', 'Omar'
    ]);
  });
  
  it("can sort a sequence by any number of keys", function() {
    var sorted = sortByKeys(patients, ["bedNumber", "roomNumber", "name"]);
    expect(map(sorted, "name")).toEqual([
      'John', 'Chris', 'Omar', 'Lisa'
    ]);
  });
});
  
function map(sequence, key) {
  var mapped = [];
  for (var i = 0; i < sequence.length; ++i) {
    mapped.push(sequence[i][key]);
  }
  return mapped;
}
