Package.describe({
  summary: 'Markdown services'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'sugar', 'http']);
  api.use(['templating'], 'client');
  api.use(['ctrl', 'util', 'stylus-compiler']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('server/main.coffee', 'server');

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use('markdown');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/tests.coffee', ['client', 'server']);

});
