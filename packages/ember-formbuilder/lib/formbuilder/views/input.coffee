Ember.FormBuilder.Input = Ember.View.extend
  tagName: Ember.FormBuilder.wrapperTag
  classNameBindings: ['wrapperClass', 'infoClass']
  template: Ember.Handlebars.compile '
    {{#if showLabel}}
      <label class="string required control-label" for="function_name">
        <abbr title="required">*</abbr> {{name}}
      </label>
    {{/if}}
    {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}
      <span></span>
      {{#if content.error}}
        {{view Ember.FormBuilder.Error text=content.error}}
      {{/if}}
      {{#if content.hint}}
        {{view Ember.FormBuilder.Help text=content.hint}}
      {{/if}}
    {{/view}}
  '
  # valueBinding: 'inputView.value'
  inputViewClass: Ember.TextField
  inputClass: ''
  name: ''

  init: ->
    @_super()
    @set 'inputWrapperTag', @get('inputWrapperTag') || Ember.FormBuilder.inputWrapperTag
    @set 'inputWrapperClass', @get('inputWrapperClass') || Ember.FormBuilder.inputWrapperClass
    @set 'wrapperClass', @get('wrapperClass') || Ember.FormBuilder.wrapperClass

    @inputViewClassChaged()
    @set 'showLabel', true if @get('showLabel') is undefined
    @set 'infoClass', @get('infoClass') || ''

  errorChanged: Ember.observer(->
    @set 'infoClass', 'error' if @get('error') isnt undefined
  , 'error')

  inputViewClassChaged: Ember.observer(->
    that = this
    @set 'inputView', @inputViewClass.create
      valueBinding: 'that.value'
  , 'inputViewClass')

  didInsertElement: ->
    if @get('inputWrapperTag')
      @get('inputView').appendTo @$().find(@get 'inputWrapperTag').find('span')
    else
      @get('inputView').appendTo @$('span')

