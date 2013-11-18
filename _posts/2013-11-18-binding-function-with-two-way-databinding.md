---
layout: post
title: "binding function on two-way-databinding"
description: "The binding function used in e2e tests doesn't work as expected on a two-way-databinding."
category: angularjs-learnings
tags: webdev angularjs
---
{% include JB/setup %}

Calling ```binding()``` on a two-way-databinding (like ```ng-model="binding-name"```) throws an error message that says ```Binding selector 'binding-name' did not match.```. I don't know the reason. Maybe I'll get an explanation on my [stackoverflow question](http://stackoverflow.com/questions/18630723/why-doesnt-binding-find-a-two-way-binding-in-an-e2e-test).