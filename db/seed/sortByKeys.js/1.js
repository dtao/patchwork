function sortByMultiple(sequence, keys) {
  var copy = copySequence(sequence);
  copy.sort(function(x, y) {
    var comparison = 0;
    for (var i = 0; i < keys.length; ++i) {
      comparison = compareBy(x, y, keys[i]);
      if (comparison !== 0) {
        return comparison;
      }
    }
    return comparison;
  });
  return copy;
}

function compareBy(x, y, key) {
  if (x[key] === y[key]) {
    return 0;
  }
  return x[key] > y[key] ? 1 : -1;
}

function copySequence(sequence) {
  var copy = [];
  for (var i = 0; i < sequence.length; ++i) {
    copy.push(sequence[i]);
  }
  return copy;
}