MyView = Ember.View.extend({
  init: function() {
    this._super()
    this.set('object',
      Ember.Object.create({
        name: '',
        books: Ember.ArrayProxy.create({
          content: []
        })
      })
    )
  }
});
