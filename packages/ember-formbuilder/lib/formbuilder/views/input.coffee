Ember.FormBuilder.Input = Ember.View.extend
  tagName: Ember.FormBuilder.wrapperTag
  classNameBindings: ['wrapperClass', 'infoClass']
  inputClass: ''
  name: ''

  init: () ->
    @_super()
    @set 'inputView', @get('inputView') || 'Ember.TextField'

    @set 'inputWrapperTag', @get('inputWrapperTag') || Ember.FormBuilder.inputWrapperTag
    @set 'inputWrapperClass', @get('inputWrapperClass') || Ember.FormBuilder.inputWrapperClass
    @set 'wrapperClass', @get('wrapperClass') || Ember.FormBuilder.wrapperClass

    @set 'showLabel', true if @get('showLabel') is undefined
    @set 'infoClass', @get('infoClass') || ''

    @set 'template', Ember.Handlebars.compile '
      {{#if showLabel}}
        <label class="string required control-label" for="function_name">
          <abbr title="required">*</abbr> {{name}}
        </label>
      {{/if}}
      {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}
        {{view ' + @inputView + ' valueBinding="content.value"}}
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
