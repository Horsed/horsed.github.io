---
title: Minification vs. Dependency Injection
author: martin
date: 2013-11-19
template: article.jade
---
AngularJS brings Dependency Injection into your app. But if you apply minification during your build process, you have to take care of not breaking your DI.

If you're using [yeoman](http://yeoman.io) to generate your AngularJS project you're probably making use of [grunt](http://gruntjs.com) to build everything. The default build configuration runs [ngmin](https://github.com/btford/ngmin) for pre-minification of your script files. That means you will have to stick to some conventions for writing controllers, services, filters etc. Take a look at ```ngmin```. This is what I ran into:

I defined a controller by hand like this:

```javascript
function MainCtrl ($scope, $routeParams) {
  ...
}
```

and it got minfied to

```javascript
function MainCtrl (a, b) {
  ...
}
```

This breaks AngularJSs' Depedency Injection. So I had to rewrite this to:

```javascript
angular.module('phvApp')
  .controller('MainCtrl', ['$scope', '$routeParams',
    function ($scope, $routeParams) {
    ...
  }]);
```