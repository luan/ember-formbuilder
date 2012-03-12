get = Ember.get
set = Ember.set
getPath = Ember.getPath

input = null

appendView = (v) ->
  Ember.run -> v.appendTo('#qunit-fixture')

module "Ember.FormBuilder.Input"
  setup: ->
    input = Ember.FormBuilder.Input.create()

  teardown: ->
    input = null

test "be set under the appropriate default wrapper", ->
  tag = Ember.FormBuilder.wrapperTag
  ok input.tagName is tag if tag
  appendView input
  cls = Ember.FormBuilder.wrapperClass
  ok input.$().hasClass(cls), "should have class #{cls}" if cls

test "be set under the appropriate custom wrapper", ->
  tag = 'span'
  input.set 'tagName', tag
  cls = 'custom'
  input.set 'wrapperClass', cls
  ok input.tagName is tag if tag
  appendView input
  ok input.$().hasClass(cls), "should have class #{cls}" if cls

test "have the input wrapper", ->
  appendView input
  ok input.$().find(Ember.FormBuilder.inputWrapperTag).hasClass(Ember.FormBuilder.inputWrapperClass)

test "generates aa input tag", ->
  appendView input
  ok input.$('input').length is 1

test "binds value correctly", ->
  myValue = ""
  input.set 'valueBinding', 'myValue'
  appendView input
  input.$('input').val('test')
  input.inputView.change()

  setTimeout 200, ->
    console.log myValue
    ok myValue is 'test'

test "has a label", ->
  appendView input
  ok input.$('label').length is 1

test "does not have a label when i dont want to", ->
  input.set 'showLabel', false
  appendView input
  ok input.$('label').length is 0

test "shows errors and hints", ->
  input.set 'error', "must me valid"
  input.set 'hint', "test@example.com"
  appendView input

  errorSelector = "#{Ember.FormBuilder.errorTag}.#{Ember.FormBuilder.errorClass}"
  ok input.$(errorSelector).length is 1
  ok input.$(errorSelector).text() is "must me valid"
  ok input.$().hasClass('error')

  hintSelector = "#{Ember.FormBuilder.helpTag}.#{Ember.FormBuilder.helpClass}"

  ok input.$(hintSelector).length is 1
  ok  in input.$(hintSelector).text() is "test@example.com"

test "works for textarea", ->
  input.set 'inputViewClass', Ember.TextArea
  appendView input
  ok input.$('textarea').length is 1

test "works for checkbox", ->
  input.set 'inputViewClass', Ember.Checkbox
  appendView input
  ok input.$('input[type=checkbox]').length is 1
