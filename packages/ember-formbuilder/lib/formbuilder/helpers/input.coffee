Ember.Handlebars.registerHelper "input", (property, options) ->
  ember_assert "The input helper only takes a single argument", arguments.length <= 2

  options.hash.valueBinding = "content.#{property}"
  options.hash.preserveContext = true

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.Input', options
