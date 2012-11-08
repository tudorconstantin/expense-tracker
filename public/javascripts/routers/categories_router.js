define([
  'jquery',
  'underscore',
  'backbone',
  'collections/categories',
  'views/categories/categories'
], function($, _, Backbone, Categories, CategoriesView){
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
