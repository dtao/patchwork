$(document).on('ready page:change', function() {
  var editors = {};

  Clean.slate();

  function afterDelay(delay, fn) {
    return setTimeout(fn, delay);
  }

  function hideNotices() {
    $('#notice, #error').slideUp();
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

  afterDelay(3000, hideNotices);

  // ----- Page-specific initialization -----

  $('#patch_language').on('change', function() {
    getEditorForTextarea('patch_tests').setOption('mode', this.value);
  });
});
