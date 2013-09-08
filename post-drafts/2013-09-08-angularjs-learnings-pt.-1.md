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

## ```binding('binding-name')``` doesn't work with two-way-databindings
Calling ```binding()``` on a two-way-databinding (like ```ng-model="binding-name"```) throws an error message that says ```Binding selector 'binding-name' did not match.```. I don't know the reason. Maybe I'll get an explanation on my (stackoverflow question)[http://stackoverflow.com/questions/18630723/why-doesnt-binding-find-a-two-way-binding-in-an-e2e-test].
