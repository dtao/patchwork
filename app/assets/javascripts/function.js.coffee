$(document).on 'ready page:load', ->
  testTemplate =
    """
    describe('name of function', function() {
      it('description of requirement', function() {
        expect('actual result').toEqual('expected result');
      });
    });
    """

  testEditor = patchwork.getOrCreateEditor('function_tests')
  testEditor.setValue(testTemplate)
