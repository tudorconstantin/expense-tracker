define([
  'jquery',
  'underscore',
  'backbone',
  'models/expense',
  'views/expenses/expense',
  'text!templates/expenses/index.html',
  'text!templates/expenses/expense_form.html'
], function($, _, Backbone, ExpenseModel, ExpenseView, listTemplate, expenseForm){
    var ExpensesView = Backbone.View.extend({

    initialize: function() {
      var self = this;

      self.template = _.template(listTemplate);
      self.formNew = _.template(expenseForm);
      
      this.collection.bind('reset', function() {        
        self.render();
      });

    },
    
    render: function() {
      var self = this;
      
      $('#expenses-container').html('');
      
      self.collection.models.forEach(function(expense) {        
        var expenseView = new ExpenseView({model: expense});
        $('#expenses-container').append(expenseView.render().el);
      });

      return self;   
    },
    
    showFormNew: function() {
      var self = this;
      
      var model = new ExpenseModel();
      var renderContent = self.formNew({model: model});
      $("#newExpenseContainer").html(renderContent);
      $('#newExpenseContainer').modal();
      console.log('rendered form', renderContent);
    }
    
    });
    return ExpensesView;
});
