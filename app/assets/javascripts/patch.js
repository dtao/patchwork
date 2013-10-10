$(document).on('ready', function() {

  $(document).on('click', '.implementation button', function() {
    var button = $(this).addClass('loading'),
        implId = button.attr('data-implementation-id');

    Patchwork.postRequest('/implementations/' + implId + '/vote', {
      success: function(data) {
        var score = button.closest('h4').find('span.score');
        score.text(Number(score.text()) + 1);
        button.hide();
      },

      failure: function() {
        button.removeClass('loading');
      }
    });
  });

  $(document).on('click', '.run-tests-for-implementation', function() {
    var link       = $(this),
        source     = link.closest('.source'),
        textarea   = source.find('.code-editor'),
        testEditor = Patchwork.getEditorForTextarea('patch_tests'),
        implEditor = Patchwork.getEditorForTextarea(textarea.get(0)),
        results    = source.find('.results');

    Patchwork.runTests({
      implementation: implEditor.getValue(),
      tests: testEditor.getValue(),
      resultCallback: function(result) {
        var result = $('<span>')
          .addClass(result.failures.length === 0 ? 'success' : 'failure')
          .text(result.failures.length === 0 ? 'PASS' : 'FAIL')
          .appendTo(results);
      }
    });
  });

});
