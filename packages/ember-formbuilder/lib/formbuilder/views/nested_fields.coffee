Ember.FormBuilder.NestedFields = Ember.CollectionView.extend Ember.Metamorph,
  init: ->
    @_super()
    @set 'content', Ember.makeArray(@content)

  itemViewClass: Ember.View.extend(Ember.Metamorph,
    tagName: 'div'
    classNameBindings: ['classes', ':nested-fields']
    form: @form
  )
