# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{(packages/ember-formbuilder/.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end
