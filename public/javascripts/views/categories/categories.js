define([
  'jquery',
  'underscore',
  'backbone',
  'views/categories/category',
  'text!templates/categories/index.html'
], function($, _, Backbone, CategoryView, listTemplate){
    var CategoriesView = Backbone.View.extend({

      initialize: function() {
        var self = this;

        self.template = _.template(listTemplate);

        this.collection.bind('reset', function() {
          console.log("Reset categories - Done, rendering will be triggered");
          self.render();
        });

      },
      
      render: function() {
        var self = this;

        self.collection.models.forEach(function(category) {
          var categoryView = new CategoryView({model: category});
          $('#categories-container').append(categoryView.render().el);
        });
 
        return self;   
      }
      
    });
    return CategoriesView;
});
