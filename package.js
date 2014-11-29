Package.describe({
  name: 'respondly:markdown',
  summary: 'Markdown services',
  version: '1.0.0',
  git: 'https://github.com/Respondly/meteor-markdown.git'
});



Npm.depends({
  'marked': '0.3.1',
  'highlight.js': '8.2.0'
});



Package.onUse(function (api) {
  api.versionsFrom('1.0');
  api.use(['coffeescript', 'http']);
  api.use('meteorhacks:async@1.0.0');
  api.use('respondly:util@1.0.0');
  api.use('respondly:css-stylus@1.0.3');
  api.export('Markdown');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('shared/ns.coffee', ['client', 'server']);
  api.addFiles('server/ns.js', 'server');
  api.addFiles('server/parse.coffee', 'server');
  api.addFiles('server/build-index.coffee', 'server');
  api.addFiles('server/server.methods.coffee', 'server');
  api.addFiles('client/css/github-markdown.css', 'client');
  api.addFiles('client/css/highlight-github.css', 'client');
  api.addFiles('client/css/overrides.styl', 'client');
  api.addFiles('client/client.coffee', 'client');
  api.addFiles('client/files.coffee', 'client');

});



Package.onTest(function (api) {
  api.use(['mike:mocha-package@0.4.7', 'coffeescript']);
  api.use('respondly:markdown');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('tests/shared/_init.coffee', ['client', 'server']);
  api.addFiles('tests/server/server.coffee', 'server');
  api.addFiles('tests/client/client.coffee', 'client');

});



Package._transitional_registerBuildPlugin({
  name: 'collectMarkdown',
  use: ['coffeescript'],
  sources: [
    'plugin/collect-markdown.coffee'
  ]
});
