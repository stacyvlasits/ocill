$(function () {
  $('#submit-audio-upload').css('background-color', 'yellow');
  $('#submit-audio-upload').click(function () {
    $(this).parent('form').submit();
  });
});