Ember.FormBuilder.Form = Ember.View.extend
  tagName: 'form'
  classNameBindings: ['classes', 'formClass']

  init: ->
    @_super()
    @set 'mixin', @mixin || 'bootstrap'
    @reopen Ember.FormBuilder.getMixin(@mixin)
