Ember.Handlebars.registerHelper "removeAssociation", (property, options) ->
  ember_assert "The removeAssociation helper only takes a single argument", arguments.length <= 2

  options.hash.valueBinding = "content.#{property}"
  options.hash.preserveContext = true
  options.hash.form = @form or this
  
  Ember.Handlebars.helpers.view.call this, 'Ember.FormBuilder.RemoveAssociation', options
