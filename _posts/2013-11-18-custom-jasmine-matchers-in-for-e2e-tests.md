---
layout: post
title: "Writing a custom Jasmine matcher for your e2e tests"
description: "How to write a custom Jasmine matcher for yout AngularJS e2e tests"
category: angularjs-learnings
tags: webdev angularjs
---
{% include JB/setup %}

Writing custom matchers in e2e tests differs from the standard [Jasmine way](https://github.com/pivotal/jasmine/wiki/Matchers#writing-new-matchers).

{% highlight javascript %}
angular.scenario.matcher('toBeReallyReallyTrue', function() {
  return this.actual === true;
});
{% endhighlight %}

You can read more about this [here](https://groups.google.com/forum/#!msg/angular/lcFXW8uv_P8/3gekqCrzSnEJ).