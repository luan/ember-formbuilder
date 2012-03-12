Ember.FormBuilder.Error = Ember.FormBuilder.Info.extend
  init: ->
    @_super()
    @set 'classes', @get('classes') || Ember.FormBuilder.errorClass
    @set 'tagName', @get('tagName') || Ember.FormBuilder.errorTag
