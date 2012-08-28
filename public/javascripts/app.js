define([
  'jquery',
  'backbone',
  'routers/expenses_router',
  'bootstrap'
], function($, Backbone, ExpensesRouter){
	App = {
    start: function(){          
    	console.log("apps start");
      var serverRouter = new ExpensesRouter;

      Backbone.history.start();
    }
  }
  return App;
});