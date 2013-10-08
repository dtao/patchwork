$(document).on('ready page:change', function() {

  // Reset any pending asynchronous operations whenever the page changes.
  Clean.slate();

  // Store CodeMirror instances so we can still interact with them after
  // initialization.
  var editors = {};

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

  function afterDelay(delay, fn) {
    return setTimeout(fn, delay);
  }

  function showNotices() {
    $('#notice, #error').css({ bottom: 0 });
    afterDelay(3000, hideNotices);
  }

  function hideNotices() {
    $('#notice, #error').slideUp(function() {
      $(this).remove();
    });
  }

  function nextEditorId() {
    editors.nextId = editors.nextId || 1;
    return editors.nextId++;
  }

  function getEditorForTextarea(textarea) {
    if (typeof textarea === 'string') {
      textarea = document.getElementById(textarea);
    }

    return editors[textarea.getAttribute('data-editor-id')];
  }

  function initializeCodeEditor(textarea) {
    var editor = CodeMirror.fromTextArea(textarea, {
      mode: textarea.getAttribute('data-language'),
      readOnly: textarea.getAttribute('data-readonly'),
      lineNumbers: true,
    });

    editor.id = nextEditorId();
    editors[editor.id] = editor;

    $(textarea).attr('data-editor-id', editor.id);
  }

  // ----- General initialization -----

  $('.code-editor').each(function() {
    initializeCodeEditor(this);
  });

  showNotices();

  // ----- Page-specific initialization -----

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

    getEditorForTextarea('patch_tests').setValue(testSource);
  }

  function addNewTestCase() {
    var testCase = $('.test-cases').find('.test-case:last');

    // Who invented jQuery's .end() method? Seriously.
    // "Let's make it *dangerously* easy to write one-liners!"
    // Anyway. I'm using it BECAUSE IT EXISTS.
    testCase.clone().find('input').val('').end().insertAfter(testCase);
  }

  $('#patch_name').on('change', updateTestEditor);

  $('#patch_language').on('change', function() {
    getEditorForTextarea('patch_tests').setOption('mode', this.value);
    updateTestEditor();
  });

  $('.add-test-case').on('click', addNewTestCase);

  $('.write-tests-manually').on('click', function() {
    $('.test-cases').slideUp(function() {
      $('.editor').slideDown(function() {
        getEditorForTextarea('patch_tests').refresh();
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
    if (e.keyCode === 9) {
      addNewTestCase();
    }
  });
});
