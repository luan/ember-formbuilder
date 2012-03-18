Ember.Handlebars.registerHelper "input", (property, options) ->
  ember_assert "The input helper only takes a single argument", arguments.length <= 2

  unless options.hash.label
    words = Ember.String.underscore(property).split('_')
    words = words.map (word) ->
      word.charAt(0).toUpperCase() + word.substring(1)

    options.hash.label = words.join(' ')
  options.hash.valueBinding = "content.#{property}"
  options.hash.preserveContext = true
  options.hash.form = this

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.Input', options
