// name: createSet
// description: create a collection that stores distinct values
describe("createSet", function() {
  var set;

  beforeEach(function() {
    set = createSet();
  });

  function ensureOnlyAddedOnce(value) {
    expect(set.add(value)).toBe(true);
    expect(set.add(value)).toBe(false);
    expect(set.toArray()).toEqual([value]);
  }

  function ensureAllAdded(values) {
    for (var i = 0; i < values.length; ++i) {
      expect(set.add(values[i])).toBe(true);
    }
    expect(set.toArray()).toEqual(values);
  }

  it("does not allow duplicate strings", function() {
    ensureOnlyAddedOnce("foo");
  });

  it("does not allow duplicate numbers", function() {
    ensureOnlyAddedOnce(5)
  });

  it("does not confuse strings and numbers", function() {
    ensureAllAdded(["5", 5]);
  });

  it("does not allow duplicate objects", function() {
    ensureOnlyAddedOnce({});
  });

  it("distinguishes between strings and objects", function() {
    ensureAllAdded(["[object Object]", "{}", {}]);
  });

  it("distinguishes between null, undefined, etc.", function() {
    ensureAllAdded(["null", "undefined", "", null, undefined, 0]);
  });
});
