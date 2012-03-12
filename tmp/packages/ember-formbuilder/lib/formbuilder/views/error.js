(function() {

  Ember.FormBuilder.Error = Ember.FormBuilder.Info.extend({
    init: function() {
      this._super();
      this.set('classes', this.get('classes') || Ember.FormBuilder.errorClass);
      return this.set('tagName', this.get('tagName') || Ember.FormBuilder.errorTag);
    }
  });

}).call(this);
