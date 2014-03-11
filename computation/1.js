// **This example illustrates the declaration and instantiation of a minimalist View.**
//
// _Working example: [1.html](../1.html)._
// _[Go to Example 2](2.html)_

// Self-executing wrapper
(function($){
  // **ListView class**: Our main app view.
  var ListView = Backbone.View.extend({
     el: $('body'), // el attaches to existing element
    // `events`: Where DOM events are bound to View methods. Backbone doesn't have a separate controller to handle such bindings; it all happens in a View.
    events: {
      'click button#add': 'addItem'
    },
    initialize: function(){
      _.bindAll(this, 'render', 'addItem'); // every function that uses 'this' as the current object should be in here

      this.counter = 0; // total number of items added thus far
      this.render();
    },
    // `render()` now introduces a button to add a new list item.
    render: function(){
      $(this.el).append("<button id='add'>Add list item</button>");
      $(this.el).append("<ul class='list'></ul>");
    },
    // `addItem()`: Custom function called via `click` event above.
    addItem: function(){
      this.counter++;
      $('ul.list', this.el).append("<li>hello world"+this.counter+"</li>");
    }
  });

  var listView = new ListView();
})(jQuery);

// <div style="float:left; margin-bottom:40px;"><img style="width:36px; margin:5px 10px 0 5px;" src="https://g.twimg.com/Twitter_logo_blue.png"/></div> <div style="background:rgb(245,245,255); padding:10px;">Follow me on Twitter: <a target="_blank" href="http://twitter.com/r2r">@r2r</a> </div>
// <script>
//   if (window.location.href.search(/\?x/) < 0) {
//     var _gaq = _gaq || [];
//     _gaq.push(['_setAccount', 'UA-924459-7']);
//     _gaq.push(['_trackPageview']);
//     (function() {
//       var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
//       ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
//       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
//     })();
//   }
// </script>