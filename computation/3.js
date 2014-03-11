(function($){
	var Item = Backbone.Model.extend({
		defaults: {
			part1: 'hello',
			part2: 'world'
		}
	});
	
	var List = Backbone.Collection.extend({
		model: Item
	});
	
	var ListView = Backbone.View.extend({
	    el: $('body'),
		events :{
		    "click button#add":"addItemModel"
		},
		render : function(){
		    $(this.el).append('<button id="add">Add An Item</button>');
            $(this.el).append('<ul></ul>');			
		},
		initialize: function(){
		    _.bindAll(this,'render','addItemModel','addItemHtml');
			this.counter = 0;
		    this.collection = new List();
			this.collection.bind('add',this.addItemHtml);
		    this.render();
		},
		addItemModel: function(){
		    var model = new Item();
			model.set({part2: model.get('part2')+' ' + this.counter});
            this.collection.add(model);
            this.counter += 1;			
		},
		addItemHtml: function(itemModel){
		    $('ul',this.el).append('<li>'+itemModel.get('part1')+" "+itemModel.get('part2')+'</li>');
		}
	});
	
	var listView = new ListView();
})(jQuery);