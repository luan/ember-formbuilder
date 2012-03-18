Ember.Handlebars.registerHelper "submit", (text, options) ->
  ember_assert "The submit helper only takes a single argument", arguments.length <= 2

  unless options
    options = text
    unless options.hash.text
      text = Ember.FormBuilder.STRINGS?[@objectName]?.submit or 'Submit'

  options.hash.preserveContext = false
  options.hash.form = this
  options.hash.text = text

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.Submit', options
