function createSet() {
  return new Set();
}

function Set() {
  this.values = [];
}

Set.prototype = {
  add: function(value) {
    if (this.contains(value)) {
      return false;
    }
    this.values.push(value);
    return true;
  },
  
  toArray: function() {
    return this.values.slice(0);
  },
  
  contains: function(value) {
    for (var i = 0; i < this.values.length; ++i) {
      if (this.values[i] === value) {
        return true;
      }
    }
    return false;
  }
};