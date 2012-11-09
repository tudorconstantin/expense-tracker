define([
  'jquery',
  'underscore',
  'backbone',
  'collections/categories',
  'views/categories/categories',
  'collections/expenses',
  'views/expenses/expenses'
], function($, _, Backbone, Categories, CategoriesView, Expenses, ExpensesView){
    var CategoriesRouter = Backbone.Router.extend({
        
        routes:{
            'categories/:category_id' : 'select'
        },

        initialize: function(){
          
          var categories = new Categories(),
              self     = this;
          
          
          categories.fetch( {
            success : function(){
              self.categoriesView = new CategoriesView({collection: categories});
              self.categoriesView.render();
              console.log('success in fetching data', categories.models);
            }
          } );
          

        },

        select: function(expense_id){
          console.log('selected categ, id:', expense_id);
          var self = this;          
          var expenses_url = ( '/categories/' + expense_id + '/expenses' );
          console.log('got url', expenses_url);
          $.get( expenses_url,
            function( data ){
              
              var expenses = new Expenses( data );
              console.log('got expenses', expenses);
              self.expensesView = new ExpensesView( {collection: expenses} );              
              self.expensesView.render();            
          });
          
          
          //expenses.fetch({
          //  success: function(){
          //    
          //  }
          //});
          //TODO: fetch expenses for this category
          //this.expensesView.collection.fetch();
          //$('#content-body').html(this.serversView.el);
          //this.expensesView.delegateEvents(); 

        }

        // defaultRoute: function(){
        //   Backbone.history.navigate("expenses", true);
        // }
        
    });

    return CategoriesRouter;

});
