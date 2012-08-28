define([
  'jquery',
  'backbone',
  'text!templates/expenses/expense.html'
], function($, Backbone, listItem){
  var ExpenseView = Backbone.View.extend({
    tagName: 'tr',

    events:{
      'click': 'showDescription'
    },

    initialize: function(){
      var self = this;
      self.model.on('change', this.render, this);
      self.template = _.template(listItem);
    },

    showDescription: function() {
      // TBD              
    },

    render: function(){
      var renderContent = this.template({model: this.model});
      $(this.el).html(renderContent);
      return this;
    }

  });

  return ExpenseView;
});
