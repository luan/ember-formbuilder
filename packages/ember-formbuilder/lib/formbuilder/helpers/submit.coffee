Ember.Handlebars.registerHelper "submit", (text, options) ->
  ember_assert "The submit helper only takes a single argument", arguments.length <= 2

  options.hash.preserveContext = false
  options.hash.form = this
  options.hash.text = text

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.Submit', options
