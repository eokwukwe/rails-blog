// http://usefulangle.com/post/41/javascript-textarea-autogrow-adjust-height-based-on-content

$(document).on('ready', function () {
  $('#comment-input').on('input', function() {
    var scroll_height = $('#comment-input').get(0).scrollHeight;

    $('#comment-input').css('height', scroll_height + 'px');
  });
})
