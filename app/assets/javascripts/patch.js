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

});
