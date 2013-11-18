---
layout: post
title: "Two-way-databinding automatically creates a model if it does not exist"
description: "Did you know that a two-way-databinding will automatically create a model on the scope when you provide a non existing one?"
category: angularjs-learnings
tags: webdev angularjs two-way-databinding
---
{% include JB/setup %}

This is can be tricky, especially when debugging:

{% highlight javascript %}
...
$scope.firstname = 'Alice';
...
{% endhighlight %}

{% highlight html %}
<input type="text" ng-model="firstName" />
{% endhighlight %}

Notice that there is a typo in firstname/firstName.