Ember.FormBuilder.RadioButton = Ember.View.extend
  checked: false
  group: "radio_button"
  disabled: false
  classNames: [ "ember-radio-button" ]
  defaultTemplate: Ember.Handlebars.compile "
    <input type=\"radio\" {{ bindAttr disabled=\"disabled\" name=\"group\" value=\"option\" checked=\"checked\"}} />
  "
  attributeBindings: ['name']

  bindingChanged: (->
    @set "checked", true  if @get("option") is get(this, "value")
  ).observes("value")

  change: ->
    Ember.run.once this, @_updateElementValue

  _updateElementValue: ->
    input = @$("input:radio")
    set this, "value", input.attr("value")
