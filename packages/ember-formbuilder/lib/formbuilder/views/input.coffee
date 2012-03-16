Ember.FormBuilder.Input = Ember.View.extend
  tagName: Ember.FormBuilder.wrapperTag
  classNameBindings: ['wrapperClass', 'infoClass']
  inputClass: ''
  label: ''

  init: () ->
    @_super()
    @set 'inputView', @get('inputView') || 'Ember.TextField'

    @set 'inputWrapperTag', @get('inputWrapperTag') || Ember.FormBuilder.inputWrapperTag
    @set 'inputWrapperClass', @get('inputWrapperClass') || Ember.FormBuilder.inputWrapperClass
    @set 'wrapperClass', @get('wrapperClass') || Ember.FormBuilder.wrapperClass

    @set 'showLabel', true if @get('showLabel') is undefined
    @set 'infoClass', @get('infoClass') || ''

    @set 'value', '' if Ember.empty(@get('value'))

    @set 'template', Ember.Handlebars.compile '
      {{#if showLabel}}
        <label class="string required control-label" for="' + Ember.guidFor(this) + 'input">
          {{label}}
        </label>
      {{/if}}
      {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}
        {{view ' + @inputView + ' id="' + Ember.guidFor(this) + 'input" class=content.inputClass valueBinding="content.value"}}
        {{#if content.error}}
          {{view Ember.FormBuilder.Error text=content.error}}
        {{/if}}
        {{#if content.hint}}
          {{view Ember.FormBuilder.Help text=content.hint}}
        {{/if}}
      {{/view}}
    '

  errorChanged: Ember.observer(->
    @set 'infoClass', 'error' if @get('error') isnt undefined
  , 'error')
