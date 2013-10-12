function repeat(str, count) {
  if (count < 1) {
    return '';
  }

  var repeated = str,
      reps     = 1;

  while (count > reps) {
    repeated += repeated;
    count -= reps;
    reps *= 2;
  }

  repeated += repeated.substring(0, str.length * (count - 1));

  return repeated;
}