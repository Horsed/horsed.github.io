---
title: ngularJS learnings pt. 4
author: martin
date: 2013-11-15
template: article.jade
descr: Binding function on two-way-databinding
---
The binding function used in e2e tests doesn't work as expected on a two-way-databinding.

Calling ```binding()``` on a two-way-databinding (like ```ng-model="binding-name"```) throws an error message that says ```Binding selector 'binding-name' did not match.```. I don't know the reason. Maybe I'll get an explanation on my [stackoverflow question](http://stackoverflow.com/questions/18630723/why-doesnt-binding-find-a-two-way-binding-in-an-e2e-test).