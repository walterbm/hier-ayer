var PUBNUB_feed = PUBNUB.init({
    subscribe_key: 'sub-c-c90f0d7c-422e-11e5-b72d-0619f8945a4f',
    ssl : true
  });

PUBNUB_feed.subscribe({
    channel: 'feed_channel',
    message: function(activity_id){
      $.get("/act/"+activity_id,function(itemHtml){
        $(itemHtml).hide().prependTo(".feed-ul").slideDown("slow");
      });
    }
});