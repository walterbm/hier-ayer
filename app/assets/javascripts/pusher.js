var pusher = new Pusher('d497d09febe0942de546', {
  encrypted: true
});

var channel = pusher.subscribe('feed_channel');

channel.bind('feed_event', function(data) {
  $.get("/act/"+data.activity_id,function(itemHtml){
    $(".feed-ul").prepend(itemHtml);
  });
});