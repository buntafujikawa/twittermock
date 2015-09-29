$(function(){
    $('.reply-btn').click(function(){
        $(this).siblings('.reply').slideToggle();
    });
});

$(function(){
    $('.retweet-btn').click(function(){
        $(this).siblings('.retweet').slideToggle();
    });
});