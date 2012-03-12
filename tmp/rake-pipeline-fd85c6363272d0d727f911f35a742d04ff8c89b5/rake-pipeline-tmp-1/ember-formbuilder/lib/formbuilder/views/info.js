(function() {

  Ember.FormBuilder.Info = Ember.View.extend({
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('{{text}}')
  });

}).call(this);
