
(function(exports) {
(function() {

  Ember.FormBuilder = Ember.Namespace.create({
    wrapperTag: 'div',
    wrapperClass: 'control-group',
    inputWrapperTag: 'div',
    inputWrapperClass: 'controls',
    labelClass: 'control-label',
    helpTag: 'p',
    helpClass: 'help-block',
    errorTag: 'span',
    errorClass: 'help-inline'
  });



























}).call(this);

})({});


(function(exports) {
(function() {

  Ember.Handlebars.registerHelper("addAssociation", function(property, options) {
    ember_assert("The addAssociation helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = "bindingContext.object." + property;
    options.hash.preserveContext = false;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.AddAssociation', options);
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.Handlebars.registerHelper("fieldsFor", function(property, options) {
    ember_assert("The fieldsFor helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = "bindingContext.object." + property;
    options.hash.preserveContext = false;
    return Ember.Handlebars.helpers.collection.call(this, 'Ember.FormBuilder.NestedFields', options);
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.Handlebars.registerHelper("formFor", function(object, options) {
    ember_assert("The formFor helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = object;
    options.hash.preserveContext = true;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.Form', options);
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.Handlebars.registerHelper("input", function(property, options) {
    ember_assert("The input helper only takes a single argument", arguments.length <= 2);
    options.hash.valueBinding = "content." + property;
    options.hash.preserveContext = true;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.Input', options);
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.Handlebars.registerHelper("removeAssociation", function(property, options) {
    ember_assert("The removeAssociation helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = "content";
    options.hash.collectionBinding = "bindingContext.content." + property;
    options.hash.preserveContext = true;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.RemoveAssociation', options);
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Info = Ember.View.extend({
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('{{text}}')
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.AddAssociation = Ember.View.extend({
    tagName: 'x',
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('{{text}}'),
    click: function(event) {
      var cls, content;
      content = this.get('content');
      cls = Ember.getPath(this.get('objectClass'));
      content.pushObject(cls.create());
      return console.log('AddAssociation');
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Error = Ember.FormBuilder.Info.extend({
    init: function() {
      this._super();
      this.set('classes', this.get('classes') || Ember.FormBuilder.errorClass);
      return this.set('tagName', this.get('tagName') || Ember.FormBuilder.errorTag);
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Form = Ember.View.extend({
    tagName: 'form',
    classNameBindings: ['classes']
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Help = Ember.FormBuilder.Info.extend({
    init: function() {
      this._super();
      this.set('classes', this.get('classes') || Ember.FormBuilder.helpClass);
      return this.set('tagName', this.get('tagName') || Ember.FormBuilder.helpTag);
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Input = Ember.View.extend({
    tagName: Ember.FormBuilder.wrapperTag,
    classNameBindings: ['wrapperClass', 'infoClass'],
    inputClass: '',
    name: '',
    init: function() {
      this._super();
      this.set('inputView', this.get('inputView') || 'Ember.TextField');
      this.set('inputWrapperTag', this.get('inputWrapperTag') || Ember.FormBuilder.inputWrapperTag);
      this.set('inputWrapperClass', this.get('inputWrapperClass') || Ember.FormBuilder.inputWrapperClass);
      this.set('wrapperClass', this.get('wrapperClass') || Ember.FormBuilder.wrapperClass);
      if (this.get('showLabel') === void 0) this.set('showLabel', true);
      this.set('infoClass', this.get('infoClass') || '');
      if (Ember.empty(this.get('value'))) this.set('value', '');
      return this.set('template', Ember.Handlebars.compile('\
      {{#if showLabel}}\
        <label class="string required control-label" for="function_name">\
          <abbr title="required">*</abbr> {{name}}\
        </label>\
      {{/if}}\
      {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}\
        {{view ' + this.inputView + ' valueBinding="content.value"}}\
        {{#if content.error}}\
          {{view Ember.FormBuilder.Error text=content.error}}\
        {{/if}}\
        {{#if content.hint}}\
          {{view Ember.FormBuilder.Help text=content.hint}}\
        {{/if}}\
      {{/view}}\
    '));
    },
    errorChanged: Ember.observer(function() {
      if (this.get('error') !== void 0) return this.set('infoClass', 'error');
    }, 'error')
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.NestedField = Ember.View.extend(Ember.Metamorph, {
    tagName: 'div',
    classNameBindings: ['classes', ':nested-fields']
  });

  Ember.FormBuilder.NestedFields = Ember.CollectionView.extend(Ember.Metamorph, {
    itemViewClass: Ember.FormBuilder.NestedField
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.RemoveAssociation = Ember.View.extend({
    tagName: 'a',
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('{{text}}'),
    click: function() {
      var collection, content;
      collection = this.get('collection');
      content = this.get('content');
      return collection.removeObject(content);
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {



}).call(this);

})({});
