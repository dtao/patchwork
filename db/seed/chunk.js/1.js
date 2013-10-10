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