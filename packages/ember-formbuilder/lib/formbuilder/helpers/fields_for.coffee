Ember.Handlebars.registerHelper "fieldsFor", (property, options) ->
  ember_assert "The fieldsFor helper only takes a single argument", arguments.length <= 2

  options.hash.content = Ember.makeArray(@content[property])
  options.hash.content.map (e) =>
    e.content = e
    e.form = this
  options.hash.preserveContext = true
  options.hash.form = this

  Ember.Handlebars.helpers.collection.call this, 'Ember.FormBuilder.NestedFields', options
