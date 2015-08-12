## Load Order

Create your own file load order rules for Meteor.

## Table of Concept

1. [Why?](#intro)
2. [How to use](#how-to-use)
3. [Configuration example](#configuration-example)

## Why?

You might want to use this package if you would like to have your own file load order rules instead of Meteor's. Also this package allows to change logic of separating client and server code.

**With this package you can:**

- Serve `*.server.js` files to server only
- Serve `*.client.js` files to client only
- Load `starter.js` and `reset.css` before everything else
- Load `block.css` files before `block__element.css` files
- Create any rules you want

Also you can **write client and server code just in the same file:**

```js
// for both
Posts = new Mongo.Collection('Posts');

// for client
Template.posts.helpers({
  posts: function() {
    return Posts.find()
  }
});

// for server
Posts.allow({
  insert: function(userId, post) {
    return userId === post.authorId;
  }
});
```

`// for both`, `// for client` and `// for server` are special comments, they are called *instructions*. It's like using `Meteor.isClient`/`Meteor.isServer`, but everything under `// for server` will not be served to client and vica verca.

## How to use

First you need to **install the package:**

```
meteor add imkost:load-order
```

After installation, `packages/load-order-config` folder will be created:

```
myapp/
  packages/
    load-order-config/
      load-order-config.coffee  <-- Write rules here (CoffeeScript)
      load-order-config.js      <-- Write rules here (JavaScript)
      load-order.min.js         <-- Don't touch this file
      package.js                <-- Don't touch this file
```

This folder keeps configuration files.

Configuration should written in `load-order-config.js` file, but if you prefer CoffeeScript, then you can write configuration in `load-order-config.coffee` file.

**How this package works:**

1. You write application in `private/app` directory
2. The package watches for file changes
3. When you do changes, `order-rules` "compiles" your app intro `_app` directory
4. Then Meteor reads your app from `_app` directory
5. That how it works

You can change paths of `private/app` and `_app` directories in configuration file.

It's recommended to exclude `_app` directory from your code editor.

Now lets see **how to create rules:**

```js
/* packages/load-order-config/load-order-config.js */
loadOrder.config = {

  // Where your application lives.
  // IMPORTANT: Must be inside `private` directory.
  sourceFolder: 'private/app',

  // Where your application will be "compiled" to.
  // Exclude this directory from code editor.
  targetFolder: '_app',

  // Instruction comments
  instructions: {
    client: 'for client',
    server: 'for server',
    shared: 'for both'
  },

  // Should return number from 0 to 9.
  // 0-files are loaded first, 9-files are loaded last.
  getLoadOrderIndex: function(filepath, filename, ext) {
    return 0;
  },

  // Should return 'client', 'server' or 'shared'.
  getLocus: function(filepath, filename, ext) {
    return 'shared';
  }

};
```

Every file in your `sourceFolder` will be passed through `getLoadOrderIndex` and `getLocus` functions.

**Example.** Let's imagine you have this file structure:

```
myapp/
  _app/
  packages/
  private/
    app/
      base/
        base.html
        base.css
        base.js
      collections/
        collections.js
```

There are four files in your `private/app` directory. All of them will be passed through `getLoadOrderIndex` and `getLocus` functions. Both of these functions accept three arguments: `filepath`, `filename` and `ext`. `filepath` is path to currently processed file, `filename` and `ext` could be easily extracted from `filepath`, but they are here just for convenience.

For example when `base.html` file will be processed through `getLocus` function, then:

- `filepath` === `private/app/base/base.html`
- `filename` === `base.html`
- `ext`      === `html`

Now lets learn **how to configure instructions:**

Instructions are indent-sensetive:

```js
// for both
Posts = new Mongo.Collection('Posts');

Meteor.startup(function() {
  // for client
  Meteor.subscribe('posts');

  // for server
  Meteor.publish('posts', function() {
    return Posts.find();
  });
});
```

Client will get this file:

```js
Posts = new Mongo.Collection('Posts');

Meteor.startup(function() {
  Meteor.subscribe('posts');
});
```

And server will get this file:

```js
Posts = new Mongo.Collection('Posts');

Meteor.startup(function() {
  Meteor.publish('posts', function() {
    return Posts.find();
  });
});
```

If your file contains one or more instructions then this file will not be passed through `getLocus`.

## Configuration Example

```js
loadOrder.config = {

  sourceFolder: 'private/app',

  targetFolder: '_app',

  instruction: {
    client: 'for client',
    server: 'for server',
    shared: 'for both'
  },

  getLoadOrderIndex: function(filepath, filename, ext) {
    if (filename === 'starter.js' || filename === 'reset.css') {
      return 0;
    }

    return 1;
  },

  getLocus: function(filepath, filename, ext) {
    if (ext === 'js') {
      if (filename.indexOf('.server.js') >= 0) {
        return 'server';
      }

      if (filename.indexOf('.client.js') >= 0) {
        return 'client';
      }

      return 'shared';
    }

    return 'client';
};
```
