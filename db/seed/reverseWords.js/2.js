function reverseWords(string) {
  var words     = [],
      lastSpace = string.lastIndexOf(' '),
      end;

  while (lastSpace !== -1) {
    words.push(string.substring(lastSpace + 1, end));
    end = lastSpace;
    lastSpace = string.lastIndexOf(' ', lastSpace - 1);
  }

  words.push(string.substring(0, end));

  return words.join(' ');
}