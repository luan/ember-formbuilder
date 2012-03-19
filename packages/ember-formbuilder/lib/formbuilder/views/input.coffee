Ember.FormBuilder.Input = Ember.View.extend
  tagNameBinding: 'wrapperTag'
  classNameBindings: ['wrapperClass', 'infoClass']
  inputClass: ''
  label: ''

  init: ->
    @_super()
    @set 'inputView', @inputView or 'Ember.TextField'

    @set 'wrapperTag', @wrapperTag or @form.wrapperTag
    @set 'wrapperClass', @wrapperClass or @form.wrapperClass
    @set 'inputWrapperTag', @inputWrapperTag or @form.inputWrapperTag
    @set 'inputWrapperClass', @inputWrapperClass or @form.inputWrapperClass
    @set 'labelClass', @labelClass or @form.labelClass
    @set 'helpTag', @helpTag or @form.helpTag
    @set 'helpClass', @helpClass or @form.helpClass
    @set 'errorTag', @errorTag or @form.errorTag
    @set 'errorClass', @errorClass or @form.errorClass

    @set 'showLabel', true if @showLabel is undefined

    @set 'value', '' if Ember.empty(@value)
    @errorChanged()

    @set 'template', Ember.Handlebars.compile '
      {{#if showLabel}}
        <label {{bindAttr class="labelClass"}} for="' + Ember.guidFor(this) + 'input">
          {{label}}
        </label>
      {{/if}}
      {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}
        ' + @field() + '
        {{#if content.error}}
          {{#view Ember.View class=content.errorClass tagNameBinding="content.errorTag" contentBinding="content"}}
            {{content.error}}
          {{/view}}
        {{/if}}
        {{#if content.hint}}
          {{#view Ember.View class=content.helpClass tagNameBinding="content.helpTag" contentBinding="content"}}
            {{content.hint}}
          {{/view}}
        {{/if}}
      {{/view}}
    '

  errorChanged: Ember.observer(->
    if Ember.empty(@error)
      @set 'infoClass', ''
    else
      @set 'infoClass', 'error'
  , 'error')

  field: ->
    switch @as
      when "select"
        @selectTag()
      else
        @textInput()

  textInput: ->
    '{{view ' + @inputView + ' id="' + Ember.guidFor(this) + 'input"
         placeholder=content.placeholder class=content.inputClass
         valueBinding="content.value"}} '
  
  selectTag: ->
    select = '{{view Ember.Select
                  contentBinding="content.collection"
                  selectionBinding="value"
                  optionLabelPath="content.label"
                  optionValuePath="content.value"'
    if @prompt
      select += ' prompt="' + @prompt + '"'

    select += '}}'
