Ember.FormBuilder.NestedField = Ember.View.extend Ember.Metamorph,
  tagName: 'div'
  classNameBindings: ['classes', ':nested-fields']

Ember.FormBuilder.NestedFields = Ember.CollectionView.extend Ember.Metamorph,
  itemViewClass: Ember.FormBuilder.NestedField.extend(form: @form)
