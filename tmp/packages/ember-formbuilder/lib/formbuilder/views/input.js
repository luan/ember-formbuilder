(function() {

  Ember.FormBuilder.Input = Ember.View.extend({
    tagName: Ember.FormBuilder.wrapperTag,
    classNameBindings: ['wrapperClass', 'infoClass'],
    template: Ember.Handlebars.compile('\
    {{#if showLabel}}\
      <label class="string required control-label" for="function_name">\
        <abbr title="required">*</abbr> {{name}}\
      </label>\
    {{/if}}\
    {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}\
      <span></span>\
      {{#if content.error}}\
        {{view Ember.FormBuilder.Error text=content.error}}\
      {{/if}}\
      {{#if content.hint}}\
        {{view Ember.FormBuilder.Help text=content.hint}}\
      {{/if}}\
    {{/view}}\
  '),
    inputViewClass: Ember.TextField,
    inputClass: '',
    name: '',
    init: function() {
      this._super();
      this.set('inputWrapperTag', this.get('inputWrapperTag') || Ember.FormBuilder.inputWrapperTag);
      this.set('inputWrapperClass', this.get('inputWrapperClass') || Ember.FormBuilder.inputWrapperClass);
      this.set('wrapperClass', this.get('wrapperClass') || Ember.FormBuilder.wrapperClass);
      this.inputViewClassChaged();
      if (this.get('showLabel') === void 0) this.set('showLabel', true);
      return this.set('infoClass', this.get('infoClass') || '');
    },
    errorChanged: Ember.observer(function() {
      if (this.get('error') !== void 0) return this.set('infoClass', 'error');
    }, 'error'),
    inputViewClassChaged: Ember.observer(function() {
      var that;
      that = this;
      return this.set('inputView', this.inputViewClass.create({
        valueBinding: 'that.value'
      }));
    }, 'inputViewClass'),
    didInsertElement: function() {
      if (this.get('inputWrapperTag')) {
        return this.get('inputView').appendTo(this.$().find(this.get('inputWrapperTag')).find('span'));
      } else {
        return this.get('inputView').appendTo(this.$('span'));
      }
    }
  });

}).call(this);
