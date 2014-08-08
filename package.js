Package.describe({
  summary: 'Markdown services'
});


Npm.depends({
  'marked': '0.3.1'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'sugar', 'http']);
  api.use(['util']);
  api.export('Markdown');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/ns.coffee', ['client', 'server']);
  api.add_files('server/server.coffee', 'server');
  api.add_files('client/client.coffee', 'client');

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use('markdown');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/server/server.coffee', 'server');
  api.add_files('tests/client/client.coffee', 'client');

});
