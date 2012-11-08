define([
  'jquery',
  'underscore',
  'backbone',
  'text!templates/categories/category.html'
], function($, _, Backbone, listItem){
  var CategoryView = Backbone.View.extend({
    
    tagName: 'li',
    events:{
      'click': 'showDescription'
    },

    initialize: function(options){
      var self = this;
      self.template = _.template(listItem);
      self.model = options.model;
    },

    showDescription: function() {
      console.log('should show description', this.model.attributes.name);
      // TBD              
    },

    render: function(){
      var self = this;
      console.log('rendering view expense.js');
      var renderContent = self.template({model: self.model});
      $(self.el).html(renderContent);
      return self;
    }

  });

  return CategoryView;
});
