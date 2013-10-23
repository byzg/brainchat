$ ->
  if ($('#chat-container').length)
    h_body = parseInt($('body').css('height'));
    h_navbar = parseInt($('.navbar.navbar-static-top').css('height'));
    $('.container-fluid').css('height', h_body - h_navbar);
    h_container_fluid = parseInt($('.container-fluid').css('height'));
    h_row_first = parseInt($('.container-fluid .row-fluid').first().css('height'));
    h_row_last_percent = ((h_container_fluid - h_row_first)/h_container_fluid)*100;
    $('.container-fluid .row-fluid').last().css('height', h_row_last_percent + "%");
    $('.container-fluid .row-fluid .span12').css('height', '100%');

    w_left_block = parseInt($('#chat-container #left_block').css('width'));
    $('#chat-container #left_block #form_message').css('width', w_left_block);
    $('#chat-container #left_block #chat-history').css('width', w_left_block);
    h_left_block = parseInt($('#chat-container #left_block').css('height'));
    h_form_message = parseInt($('#chat-container #left_block #form_message').css('height'));
    $('#chat-container #left_block #chat-history').css('max-height', h_left_block - h_form_message - 10);
    t_last_message = parseInt($('.chat-history-message').last().offset().top + $('.chat-history-message').last().css('height'))
    $('#chat-history').scrollTop(t_last_message);
