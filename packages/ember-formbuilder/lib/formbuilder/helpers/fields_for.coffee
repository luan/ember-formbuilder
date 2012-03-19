Ember.Handlebars.registerHelper "fieldsFor", (property, options) ->
  ember_assert "The fieldsFor helper only takes a single argument", arguments.length <= 2

  options.hash.contentBinding = "content.#{property}"
  options.hash.preserveContext = false
  options.hash.form = this

  Ember.Handlebars.helpers.collection.call this, 'Ember.FormBuilder.NestedFields', options
