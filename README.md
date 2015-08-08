## Load Order

Create your own file load order rules for Meteor.

## Installation

```
meteor add imkost:load-order
```

After installation `packages/load-order-config` folder will be created.

## Configuration file

```
myapp/
  packages/
    load-order-config/
      load-order-config.coffee  <-- Write config here (CoffeeScript)
      load-order-config.js      <-- Write config here (JavaScript)
      load-order.min.js
      package.js
```

## Configuration

```js
loadOrder.config = {
  // Where your application lives.
  // Must be inside `private` directory.
  sourceFolder: 'private/app',

  // Where your application will be "compiled" to.
  // Exclude this directory from code editor.
  targetFolder: '_app',

  // Should return number from 0 to 9.
  // 0 files are loaded first, 9 files are loaded last.
  getLoadOrderIndex: function(filepath, filename, ext) {
    return 0;
  },

  // Should return 'client', 'server' or 'shared'.
  getLocus: function(filepath, filename, ext) {
    return 'shared';
  }
};
```
