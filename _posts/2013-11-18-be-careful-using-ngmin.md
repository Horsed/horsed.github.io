---
layout: post
title: "Minification vs. Dependency Injection"
description: "AngularJS brings Dependency Injection into your app. But if you apply minification during your build process, you have to take care of not breaking your DI."
category: angularjs-learnings
tags: webdev angularjs dependency-injection minification yeoman
---
{% include JB/setup %}

If you're using [yeoman](http://yeoman.io) to generate your AngularJS project you're probably making use of [grunt](http://gruntjs.com) to build everything. The default build configuration runs [ngmin](https://github.com/btford/ngmin) for pre-minification of your script files. That means you will have to stick to some conventions for writing controllers, services, filters etc. Take a look at ```ngmin```. This is what I ran into:

I defined a controller by hand like this:

{% highlight javascript %}
function MainCtrl ($scope, $routeParams) {
  ...
}
{% endhighlight %}

and it got minfied to

{% highlight javascript %}
function MainCtrl (a, b) {
  ...
}
{% endhighlight %}

This breaks AngularJSs' Depedency Injection. So I had to rewrite this to:

{% highlight javascript %}
angular.module('phvApp').controller('MainCtrl', ['$scope', '$routeParams', function ($scope, $routeParams) {
  ...
}]);
{% endhighlight %}