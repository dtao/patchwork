function reverseWords(string) {
  var words = string.split(/\s+/);
  words.reverse();
  return words.join(' ');
}