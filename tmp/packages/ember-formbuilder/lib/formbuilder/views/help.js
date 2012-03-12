(function() {

  Ember.FormBuilder.Help = Ember.FormBuilder.Info.extend({
    init: function() {
      this._super();
      this.set('classes', this.get('classes') || Ember.FormBuilder.helpClass);
      return this.set('tagName', this.get('tagName') || Ember.FormBuilder.helpTag);
    }
  });

}).call(this);
