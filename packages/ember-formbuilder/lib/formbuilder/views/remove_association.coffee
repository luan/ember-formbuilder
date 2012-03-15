Ember.FormBuilder.RemoveAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    collection = @get('collection')
    content = @get('content')
    collection.removeObject(content)
