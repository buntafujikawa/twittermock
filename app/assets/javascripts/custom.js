$(function(){
    $('.reply-btn').click(function(){
        // siblingsは兄弟
        $(this).siblings('.reply').slideToggle();
    });
});