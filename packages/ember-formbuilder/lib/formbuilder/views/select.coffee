Ember.FormBuilder.Select = Ember.Select.extend
  init: ->
    @_super()
    @attributeBindings.push 'name'

