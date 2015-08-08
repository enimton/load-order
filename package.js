Package.describe({
  name          : 'imkost:load-order',
  version       : '0.2.0',
  summary       : 'Allows to create your own file load order rules',
  git           : 'https://github.com/imkost/load-order',
  documentation : 'README.md'
});

Package.registerBuildPlugin({
  name: 'load-order',
  npmDependencies: {
    'glob'   : '5.0.5',
    'mkdirp' : '0.5.0',
    'rimraf' : '2.3.2'
  },
  use: [ 'coffeescript@1.0.6' ],
  sources: [
    'loadOrder/loadOrder.coffee',
    'loadOrder/loadOrder.FILES_load-order-config-coffee.coffee',
    'loadOrder/loadOrder.FILES_load-order-config-js.coffee',
    'loadOrder/loadOrder.FILES_load-order-min-js.coffee',
    'loadOrder/loadOrder.FILES_package.coffee',
    'loadOrder/loadOrder.--Generate-config-files.coffee',
    'loadOrder/loadOrder.--Add-config-to-list-of-packages.coffee'
  ]
});
