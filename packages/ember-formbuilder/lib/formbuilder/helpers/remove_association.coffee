Ember.Handlebars.registerHelper "removeAssociation", (property, options) ->
  ember_assert "The removeAssociation helper only takes a single argument", arguments.length <= 2

  options.hash.contentBinding = "content"
  options.hash.collectionBinding = "bindingContext.content.#{property}"
  options.hash.preserveContext = true

  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.RemoveAssociation', options
