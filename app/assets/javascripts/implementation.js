$(document).on('ready page:load', function() {

  // There is almost certainly a better way to do this; but I don't want to
  // think about that just yet.
  var JASMINE_TEMPLATE = [
    'describe("{{name}}", function() {',
    '',
    '  {{#testCases}}',
    '  it("{{{escapedInput}}} => {{{escapedOutput}}}", function() {',
    '    expect({{name}}({{{input}}})).toEqual({{{output}}});',
    '  });',
    '',
    '  {{/testCases}}',
    '});'
  ].join('\n');

  var RSPEC_TEMPLATE = [
    'describe "{{name}}" do',
    '',
    '  {{#testCases}}',
    '  it "{{{escapedInput}}} => {{{escapedOutput}}}" do',
    '    {{name}}({{{input}}}).should == {{{output}}}',
    '  end',
    '',
    '  {{/testCases}}',
    'end'
  ].join('\n');

  function getSimpleTestCases() {
    return $('.test-case').map(function() {
      var input  = $('.input input', this).val(),
          output = $('.output input', this).val();

      if (!input || !output) {
        return;
      }

      return {
        input: input,
        output: output,
        escapedInput: input.replace(/"/g, '\''),
        escapedOutput: output.replace(/"/g, '\'')
      };
    }).toArray();
  }

  function updateTestEditor() {
    var template = $('#patch_language').val() === 'javascript' ?
      JASMINE_TEMPLATE : RSPEC_TEMPLATE;

    var testSource = Mustache.render(template, {
      name: $('#patch_name').val(),
      testCases: getSimpleTestCases()
    });

    Patchwork.getEditorForTextarea('patch_tests').setValue(testSource);
  }

  function isLastTestCase(element) {
    return $(element).closest('.test-case').next('.test-case').length === 0;
  }

  function addNewTestCase() {
    var testCase = $('.test-cases').find('.test-case:last');

    // Who invented jQuery's .end() method? Seriously.
    // "Let's make it *dangerously* easy to write one-liners!"
    // Anyway. I'm using it BECAUSE IT EXISTS.
    testCase.clone().find('input').val('').end().insertAfter(testCase);
  }

  function createGutterMarker(success) {
    var marker = $('<span>')
      .addClass(success ? 'success' : 'failure')
      .text(success ? ':)' : ':(');

    return marker.get(0);
  }

  $('#patch_name').on('change', updateTestEditor);

  $('#patch_language').on('change', function() {
    Patchwork.getEditorForTextarea('patch_tests').setOption('mode', this.value);
    updateTestEditor();
  });

  $('.add-test-case').on('click', addNewTestCase);

  $('.write-tests-manually').on('click', function() {
    $('.test-cases').slideUp(function() {
      $('.editor').slideDown(function() {
        Patchwork.getEditorForTextarea('patch_tests').refresh();
      });
    });
  });

  $('.simple-test-cases').on('click', function() {
    $('.editor').slideUp(function() {
      $('.test-cases').slideDown();
    });
  });

  $('.test-cases').on('change', '.test-case input', updateTestEditor);

  $('.test-cases').on('keydown', '.test-case .output > input', function(e) {
    if (e.keyCode === 9 && isLastTestCase(this)) {
      addNewTestCase();
    }
  });

  $('.run-tests').click(function() {
    var implEditor = Patchwork.getEditorForTextarea('implementation_source'),
        testEditor = Patchwork.getEditorForTextarea('patch_tests');

    Patchwork.runTests({
      implementation: implEditor.getValue(),
      tests: testEditor.getValue(),
      resultCallback: function(result) {
        var description = result.description,
            success     = result.failures.length === 0;

        for (var i = 0; i < testEditor.lineCount(); ++i) {
          if (testEditor.getLine(i).indexOf(description) !== -1) {
            testEditor.setGutterMarker(i, 'test-results', createGutterMarker(success));
          }
        }
      }
    });
  });

});
