Ember.FormBuilder.Checkbox = Ember.Checkbox.extend
  tagName: ''

  id: Ember.computed(->
    Ember.guidFor(this)
  )

  defaultTemplate: Ember.Handlebars.compile '
    <input type="checkbox"{{bindAttr id="id" name="name" checked="value" disabled="disabled"}}>
  '
