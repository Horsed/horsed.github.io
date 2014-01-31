---
title: Nested Node domains
author: martin
date: 2014-01-31
template: article.jade
descr: Understanding error handling with Node's domain and multiple EventEmitters
---
Anyway, here is some code about that tricky error handling with nested ```domains```:

```javascript
var search = bower.commands.search(packageName, {});

var d = domain.create();
d.on('error', function(err) {
  errFn(err);
});
d.add(search);

d.run(function() {
  search.on('end', function (results) {
    if(results.length > 0) {
      var install = bower.commands.install(
        packageName,
        {save:false},
        {cwd: "output", directory: "bower_components"});

      var d = domain.create();
      d.on('error', function(err) {
        errFn(err);
      });
      d.add(install);

      d.run(function() {
        install.on('end', function(installed) {
          // do something            
        });
      });
    } else {
      errFn('package ' + packageName + ' not found');
    }
  });
});
```

The ```bower.commands``` ```search``` and ```install``` are ```EventEmitters``` and in this example ```install``` is created inside an event handler of ```search```. Using ```domain``` for error handling requires you to add all ```EventEmitters``` being used inside the ```domain.run(function() {})``` function to the domain **before** the run function gets set. ```install``` is created inside of ```search.on('end',...``` which in turn is executed in the outer ```domain```. That means, ```install``` can't be added to the outer domain anymore. It has to be used inside another ```domain```. That's why there is an inner ```domain```.