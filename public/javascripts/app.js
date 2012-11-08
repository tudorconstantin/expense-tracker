define([
  'jquery',
  'underscore',
  'backbone',
  'routers/categories_router',
  'bootstrap'
], function($, _, Backbone, CategoriesRouter){
	var App = {
    start: function(){          
    	
      console.log("apps start");

      //var expensesRouter = new ExpensesRouter;
      var categoriesRouter = new CategoriesRouter;

      Backbone.history.start();
    }
  };
  return App;
});