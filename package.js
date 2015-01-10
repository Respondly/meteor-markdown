Package.describe({
  summary: 'Markdown services'
});



Npm.depends({
  'marked': '0.3.1',
  'highlight.js': '8.2.0'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'http']);
  api.use(['respondly:util', 'respondly:css-stylus']);
  api.export('Markdown');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/ns.coffee', ['client', 'server']);
  api.add_files('server/ns.js', 'server');
  api.add_files('server/parse.coffee', 'server');
  api.add_files('server/build-index.coffee', 'server');
  api.add_files('server/server.methods.coffee', 'server');
  api.add_files('client/css/github-markdown.css', 'client');
  api.add_files('client/css/highlight-github.css', 'client');
  api.add_files('client/css/overrides.styl', 'client');
  api.add_files('client/client.coffee', 'client');
  api.add_files('client/files.coffee', 'client');

});



Package.on_test(function (api) {
  api.use('respondly:markdown');
  api.use(['coffeescript', 'mike:mocha-package@0.4.7']);
  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/server/server.coffee', 'server');
  api.add_files('tests/client/client.coffee', 'client');

});



Package._transitional_registerBuildPlugin({
  name: 'collectMarkdown',
  use: ['coffeescript'],
  sources: [
    'plugin/collect-markdown.coffee'
  ]
});
