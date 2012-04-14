(function() {

  describe("Foo", function() {
    return it("it is not bar", function() {
      var v;
      v = true;
      return expect(v).toEqual(true);
    });
  });

}).call(this);