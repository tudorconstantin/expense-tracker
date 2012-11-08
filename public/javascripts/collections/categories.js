define([
  'jquery',
  'underscore',
  'backbone',
  'models/category'
], function($, _, Backbone, category){
  var Categories = Backbone.Collection.extend({
    model: category,

    url: "/api/categories",

    initialize: function() {
      console.log('should fetch categories');
    },

    expenseCreate: function(data) {
      // TBD
    },

    expenseDelete: function(data) {
      // TBD
    }

    });
    return Categories;
});