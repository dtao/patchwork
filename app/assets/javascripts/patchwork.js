$(document).on('page:fetch', function() {
  Patchwork.afterDelay(300, function() {
    $('body').addClass('loading');
  });
});

$(document).on('ready page:load', function() {

  // Reset any pending asynchronous operations whenever the page changes.
  Clean.slate();

  // Store CodeMirror instances so we can still interact with them after
  // initialization.
  var editors = {};

  function afterDelay(delay, fn) {
    return setTimeout(fn, delay);
  }

  function displayNotice(message, type) {
    type = type || 'notice';

    var notice = $('<div id="' + type + '">')
      .text(message)
      .appendTo('body');

    afterDelay(0, showNotices());
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
    var options = {
      mode: textarea.getAttribute('data-language'),
      readOnly: textarea.getAttribute('data-readonly'),
      lineNumbers: true
    };

    if (textarea.getAttribute('data-extra-gutter')) {
      options.gutters = ['CodeMirror-linenumbers', textarea.getAttribute('data-extra-gutter')];
    }

    var editor = CodeMirror.fromTextArea(textarea, options);

    editor.id = nextEditorId();
    editors[editor.id] = editor;

    $(textarea).attr('data-editor-id', editor.id);
  }

  function getCallbacksWithDefaults(callbacks) {
    callbacks = callbacks || {};

    return {
      success: callbacks.success || function() {},
      failure: callbacks.failure || function() {},
      completion: callbacks.completion || function() {}
    };
  }

  function popArgument(args) {
    return Array.prototype.pop.call(args);
  }

  function postRequest() {
    var url       = arguments[0],
        callbacks = getCallbacksWithDefaults(popArgument(arguments)),
        data      = popArgument(arguments);

    var request = $.post(url, data);

    request.done(function(data) {
      if (data.status === 'error') {
        displayNotice(data.message, 'error');
        callbacks.failure();
        return;
      }

      displayNotice(data.message);
      callbacks.success(data);
    });

    request.fail(function() {
      displayNotice('An unexpected error occurred. Try again later?', 'error');
      callbacks.failure();
    });

    request.always(callbacks.completion);
  }

  function runTests(options) {
    var testRunner = new Worker('/javascripts/testRunner.js');

    var runnerTimeout = Patchwork.afterDelay(3000, function() {
      testRunner.terminate();
      Patchwork.displayNotice('The tests took longer than 3 seconds to run.', 'error');

      if (options.completionCallback) {
        options.completionCallback();
      }
    });

    testRunner.addEventListener('message', function(e) {
      var data = JSON.parse(e.data);

      if (data.finished) {
        clearTimeout(runnerTimeout);
        if (options.completionCallback) {
          options.completionCallback();
        }
        return;
      }

      if (data.message) {
        clearTimeout(runnerTimeout);
        Patchwork.displayNotice(data.message, 'error');
        if (options.completionCallback) {
          options.completionCallback();
        }
        return;
      }

      options.resultCallback(data);
    });

    testRunner.postMessage(JSON.stringify({
      implementation: options.implementation,
      tests: options.tests
    }));
  }

  // ----- General initialization -----

  $('.code-editor').each(function() {
    initializeCodeEditor(this);
  });

  showNotices();

  // Expose Patchwork namespace for other files to access some of the
  // functionality in here.
  window.Patchwork = {
    afterDelay: afterDelay,
    displayNotice: displayNotice,
    showNotices: showNotices,
    getEditorForTextarea: getEditorForTextarea,
    initializeCodeEditor: initializeCodeEditor,
    postRequest: postRequest,
    runTests: runTests
  };

  $('body').removeClass('loading');

});
