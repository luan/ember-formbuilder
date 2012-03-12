Ember.FormBuilder.Help = Ember.FormBuilder.Info.extend
  init: ->
    @_super()
    @set 'classes', @get('classes') || Ember.FormBuilder.helpClass
    @set 'tagName', @get('tagName') || Ember.FormBuilder.helpTag
