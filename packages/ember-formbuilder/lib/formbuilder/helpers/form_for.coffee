Ember.Handlebars.registerHelper "formFor", (object, options) ->
  ember_assert "The formFor helper only takes a single argument", arguments.length <= 2

  options.hash.contentBinding = object
  options.hash.preserveContext = true

  Ember.Handlebars.helpers.view.call this, Ember.FormBuilder.Form, options
