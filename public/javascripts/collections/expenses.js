define([
  'jquery',
  'underscore',
  'backbone',
  'models/expense'
], function($, _, Backbone, expense){
  var Expenses = Backbone.Collection.extend({
    model: expense,

    url: "/api/operations",

    initialize: function() {
      console.log('should fetch expenses');
    },

    expenseCreate: function(data) {
      // TBD
    },

    expenseDelete: function(data) {
      // TBD
    }

    });
    return Expenses;
});