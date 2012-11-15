define([
  'jquery',
  'underscore',
  'backbone',
  'collections/expenses',
  'views/expenses/expenses'
], function($, _, Backbone, Expenses, ExpensesView){
    var ExpensesRouter = Backbone.Router.extend({
        
        routes:{
            'expenses/new' : 'newExpense',
            'expenses/:expense_id' : 'select',
            
        },

        initialize: function(){
          
          //var expenses = new Expenses(),
          //    self     = this;
          //
          //
          //expenses.fetch( {
          //  success : function(){
          //    self.expensesView = new ExpensesView({collection: expenses});
          //    self.expensesView.render();
          //    console.log('success in fetching data', expenses.models);
          //  }
          //} );
          

        },
        
        newExpense: function(){
            console.log('hello');
            var expenses = new Expenses();
            self.expenseForm = new ExpensesView( {collection: expenses} );
            self.expenseForm.showFormNew();
            
        },

        select: function(expense_id){
            console.log('Expense selected');
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
