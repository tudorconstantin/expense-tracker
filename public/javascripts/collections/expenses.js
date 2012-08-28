define([
  'backbone',
  'models/expense'
], function(Backbone, expense){
  var Expenses = Backbone.Collection.extend({
    model: expense,

    url: "expenses",

    initialize: function() {

    },

    expenseCreate: function(data) {
      // TBD
    },

    expenseDelete: function(data) {
      // TBD
    }

    });
    return BaseDisks;
});