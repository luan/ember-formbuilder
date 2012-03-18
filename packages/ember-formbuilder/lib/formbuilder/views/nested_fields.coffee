Ember.FormBuilder.NestedFields = Ember.CollectionView.extend Ember.Metamorph,
  itemViewClass: Ember.View.extend Ember.Metamorph,
    classNameBindings: ['classes', ':nested-fields']
    form: @form

    init: ->
      @_super()
      @set 'mixin', @mixin or @form.mixin or 'bootstrap'
      @reopen Ember.FormBuilder.getMixin(@mixin)

