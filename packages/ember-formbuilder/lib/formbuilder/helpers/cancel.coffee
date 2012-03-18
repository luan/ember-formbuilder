Ember.Handlebars.registerHelper "cancel", (text, options) ->
  ember_assert "The cancel helper only takes a single argument", arguments.length <= 2

  unless options
    options = text
    unless options.hash.text
      text = Ember.FormBuilder.STRINGS?[@objectName]?.cancel or 'Cancel'

  options.hash.preserveContext = false
  options.hash.form = this
  options.hash.text = text

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.Cancel', options
