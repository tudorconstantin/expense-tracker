define([
  'jquery',
  'underscore',
  'backbone',
  'routers/expenses_router',
  'bootstrap'
], function($, _, Backbone, ExpensesRouter){
	App = {
    start: function(){          
    	console.log("apps start");
      var serverRouter = new ExpensesRouter;

      Backbone.history.start();
    }
  }
  return App;
});