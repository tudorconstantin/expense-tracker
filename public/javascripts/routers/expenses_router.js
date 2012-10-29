define([
  'jquery',
  'underscore',
  'backbone',
  'collections/expenses',
  'views/expenses/expenses'
], function($, _, Backbone, Expenses, ExpensesView){
    var ExpensesRouter = Backbone.Router.extend({
        
        routes:{
            'expenses/:expense_id' : 'select'
        },

        initialize: function(){
          
          var expenses = new Expenses(),
              self     = this;
          
          
          expenses.fetch( {
            success : function(){
              self.expensesView = new ExpensesView({collection: expenses});
              self.expensesView.render();
              console.log('success in fetching data', expenses.models);
            }
          } );
          

        },

        select: function(expense_id){
          //this.expensesView.collection.fetch();
          //$('#content-body').html(this.serversView.el);
          //this.expensesView.delegateEvents(); 

        }

        // defaultRoute: function(){
        //   Backbone.history.navigate("expenses", true);
        // }
        
    });

    return ExpensesRouter;

});
