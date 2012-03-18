Ember.FormBuilder.RemoveAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    console.log @content
    collection = @collection
    content = @content
    collection.removeObject(content)
