window.App = Ember.Application.create();

App.MyView = Ember.View.extend({
  init: function() {
    this._super();
    this.set('object',
      Ember.Object.create({
        name: 'asd',
        books: Ember.ArrayProxy.create({
          content: [
            Ember.Object.create({title: 'bigorna'})
          ]
        })
      })
    );
    window.object = this.get('object');
  }
});

