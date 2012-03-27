Ember.Handlebars.registerHelper "input", (property, options) ->
  ember_assert "The input helper only takes a single argument", arguments.length <= 2

  for attribute in Ember.String.w('label hint placeholder')
    unless options.hash[attribute]
      options.hash[attribute] = Ember.FormBuilder.STRINGS?[@objectName]?[attribute + 's']?[property]
      unless options.hash[attribute]
        options.hash[attribute] = Ember.FormBuilder.STRINGS?.defaults?[attribute + 's']?[property]

  unless options.hash.label
    words = Ember.String.underscore(property).split('_')
    words = words.map (word) ->
      word.charAt(0).toUpperCase() + word.substring(1)

    options.hash.label = words.join(' ')

  options.hash.valueBinding = "content.#{property}"
  options.hash.name = property
  options.hash.preserveContext = true
  options.hash.form = @form or this

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.Input', options
