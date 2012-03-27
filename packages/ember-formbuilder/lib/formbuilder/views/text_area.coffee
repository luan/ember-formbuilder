Ember.FormBuilder.TextArea = Ember.TextArea.extend
  init: ->
    @_super()
    @attributeBindings.push 'name'

