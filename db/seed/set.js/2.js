function createSet() {
  return new Set();
}

function Set() {
  this.values = [];
  this.string = {};
  this.number = {};
}

Set.prototype = {
  add: function(value) {
    var type   = typeof value,
        values = this.values;

    switch (type) {
      case 'string':
      case 'number':
        if (!this[type][value]) {
          this[type][value] = true;
          values.push(value);
          return true;
        }
        
        return false;
    }

    for (var i = 0; i < values.length; ++i) {
      if (value === values[i]) {
        return false;
      }
    }

    values.push(value);
    return true;
  },
  
  toArray: function() {
    return this.values.slice(0);
  }
};