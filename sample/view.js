window.App = Ember.Application.create();
App.set('genders', Ember.ArrayProxy.create({
  content: [
    Ember.Object.create({label: 'Male', value: 1}),
    Ember.Object.create({label: 'Female', value: 2})
  ]
}));
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

