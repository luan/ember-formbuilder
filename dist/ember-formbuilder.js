
(function(exports) {
(function() {
  var Bootstrap;

  Bootstrap = Ember.Mixin.create({
    wrapperTag: 'div',
    wrapperClass: 'control-group',
    inputWrapperTag: 'div',
    inputWrapperClass: 'controls',
    labelClass: 'control-label',
    helpTag: 'p',
    helpClass: 'help-block',
    errorTag: 'span',
    errorClass: 'help-inline',
    formClass: 'form-vertical',
    submitClass: 'btn btn-success',
    cancelClass: 'btn btn-danger'
  });

  Ember.FormBuilder = Ember.Namespace.create({
    mixins: {
      'bootstrap': Bootstrap
    },
    pushMixin: function(mixin, mixinName) {
      return this.mixins[mixinName] = mixin;
    },
    getMixin: function(mixinName) {
      return this.mixins[mixinName];
    }
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
    options.hash.form = this;
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
    var words;
    ember_assert("The input helper only takes a single argument", arguments.length <= 2);
    if (!options.hash.label) {
      words = Ember.String.underscore(property).split('_');
      words = words.map(function(word) {
        return word.charAt(0).toUpperCase() + word.substring(1);
      });
      options.hash.label = words.join(' ');
    }
    options.hash.valueBinding = "content." + property;
    options.hash.preserveContext = true;
    options.hash.form = this;
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

  Ember.FormBuilder.AddAssociation = Ember.View.extend({
    tagName: 'a',
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('{{text}}'),
    click: function() {
      var cls, content;
      content = this.content;
      cls = Ember.getPath(this.objectClass);
      return content.pushObject(cls.create());
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Form = Ember.View.extend({
    tagName: 'form',
    classNameBindings: ['classes', 'formClass'],
    init: function() {
      this._super();
      this.set('mixin', this.mixin || 'bootstrap');
      return this.reopen(Ember.FormBuilder.getMixin(this.mixin));
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {

  Ember.FormBuilder.Input = Ember.View.extend({
    tagNameBinding: 'wrapperTag',
    classNameBindings: ['wrapperClass', 'infoClass'],
    inputClass: '',
    label: '',
    init: function() {
      this._super();
      this.set('inputView', this.inputView || 'Ember.TextField');
      this.set('wrapperTag', this.wrapperTag || this.form.wrapperTag);
      this.set('wrapperClass', this.wrapperClass || this.form.wrapperClass);
      this.set('inputWrapperTag', this.inputWrapperTag || this.form.inputWrapperTag);
      this.set('inputWrapperClass', this.inputWrapperClass || this.form.inputWrapperClass);
      this.set('labelClass', this.labelClass || this.form.labelClass);
      this.set('helpTag', this.helpTag || this.form.helpTag);
      this.set('helpClass', this.helpClass || this.form.helpClass);
      this.set('errorTag', this.errorTag || this.form.errorTag);
      this.set('errorClass', this.errorClass || this.form.errorClass);
      if (this.showLabel === void 0) this.set('showLabel', true);
      if (Ember.empty(this.value)) this.set('value', '');
      this.errorChanged();
      return this.set('template', Ember.Handlebars.compile('\
      {{#if showLabel}}\
        <label {{bindAttr class="labelClass"}} for="' + Ember.guidFor(this) + 'input">\
          {{label}}\
        </label>\
      {{/if}}\
      {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}\
        {{view ' + this.inputView + ' id="' + Ember.guidFor(this) + 'input" class=content.inputClass valueBinding="content.value"}}\
        {{#if content.error}}\
          {{#view Ember.View class=content.errorClass tagNameBinding="content.errorTag" contentBinding="content"}}\
            {{content.error}}\
          {{/view}}\
        {{/if}}\
        {{#if content.hint}}\
          {{#view Ember.View class=content.helpClass tagNameBinding="content.helpTag" contentBinding="content"}}\
            {{content.hint}}\
          {{/view}}\
        {{/if}}\
      {{/view}}\
    '));
    },
    errorChanged: Ember.observer(function() {
      if (Ember.empty(this.error)) {
        return this.set('infoClass', '');
      } else {
        return this.set('infoClass', 'error');
      }
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
    itemViewClass: Ember.FormBuilder.NestedField.extend({
      form: this.form
    })
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
      collection = this.collection;
      content = this.content;
      return collection.removeObject(content);
    }
  });

}).call(this);

})({});


(function(exports) {
(function() {



}).call(this);

})({});
