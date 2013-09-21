---
layout: post
title: "AngularJS learnings pt. 1"
description: "Some details to know about when developing in AngularJS"
category: 
tags: webdev angularjs
---
{% include JB/setup %}

This might be a continuous topic. I'm learning AngularJS and there are a few things about it that caused some serious WTFs. I'm writing this stuff down to (hopefully) remember it. So here it goes.

## Test output
Ok, this is actually not specific to AngularJS but to Karma/Jasmine. Whenever a test fails due to an unavailable function you get a message like this:

{% highlight javascript %}
TypeError: 'undefined' is not a function (evaluating 'element('form').submit()')
{% endhighlight %}


Remember: It's the last mentioned function that's ```undefined```! So in this case it is the ```submit``` function.

## binding('binding-name') doesn't work with two-way-databindings
Calling ```binding()``` on a two-way-databinding (like ```ng-model="binding-name"```) throws an error message that says ```Binding selector 'binding-name' did not match.```. I don't know the reason. Maybe I'll get an explanation on my [stackoverflow question](http://stackoverflow.com/questions/18630723/why-doesnt-binding-find-a-two-way-binding-in-an-e2e-test).

## Custom Jasmine matchers in E2E tests ([source](https://groups.google.com/forum/#!msg/angular/lcFXW8uv_P8/3gekqCrzSnEJ))
Writing custom matchers in E2E tests differs from the standard [Jasmine way](https://github.com/pivotal/jasmine/wiki/Matchers#writing-new-matchers).

{% highlight javascript %}
angular.scenario.matcher('toBeReallyReallyTrue', function() {
  return this.actual === true;
});
{% endhighlight %}

## Using [ngmin](https://github.com/btford/ngmin): Know the conventions!
If you're using [yeoman](http://yeoman.io) to generate your AngularJS project you're probably making use of [grunt](http://gruntjs.com) to build everything. The default build configuration runs ````ngmin``` for pre-minification of your script files. That means you will have to stick to some conventions for writing controllers, services, filters etc. Take a look at ```ngmin```. This is what I ran into:

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

## Two-way-databinding automatically generates a model if it does not exist
Not just useful, especially when debugging:

{% highlight javascript %}
...
$scope.firstname = 'Alice';
...
{% endhighlight %}

{% highlight html %}
<input type="text" ng-model="firstName" />
{% endhighlight %}
