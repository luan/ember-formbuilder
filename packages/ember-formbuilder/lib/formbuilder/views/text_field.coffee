Ember.FormBuilder.TextField = Ember.TextField.extend
  init: ->
    @_super()
    @attributeBindings.push 'name'
