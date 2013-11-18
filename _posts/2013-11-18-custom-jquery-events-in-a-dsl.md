---
layout: post
title: "Trigger jQuery events in a custom dsl"
description: "When developing dynamic frontends with jQuery you will most likely be making use of events (e.g. mouseover). In AngularJS this event handling code usually lies in directives. When it comes to testing these directives in e2e tests, you may want to trigger some of these events. Angular uses it's jqLite for e2e test where you might be looking first for some events you can trigger. But since jqLite is only a subset of jquery it doesn't provide all events supported by jquery."
category: angularjs-learnings
tags: webdev angularjs jquery e2e dsl
---
{% include JB/setup %}

I wanted to e2e test a directive which shows and hides another element when hovering over the directive's element. I wrote a custom dsl to trigger the ```mouseover``` event on a given element. But the event didn't seem to fire inside the e2e tests although it worked in the browser. Here is the code:

{%highlight html %}
<span class="master" show-hide=".slave">...</span>
<span class="slave">...</span>
{% endhighlight %}

The e2e test looked like this:

{% highlight javascript %}
angular.scenario.dsl('mouseover', function() {
  return function(selector) {
    return this.addFutureAction('Calling mouseover of given element', function($window, $document, done) {
      $document.find(selector).trigger('mouseover');
      done();
    });
  };
});

...

it('should show slave', function() {
  expect(element('.slave').css('display')).toBe('none');
  
  mouseover('.master');

  expect(element('.slave').css('display')).not().toBe('none');
});
{% endhighlight %}

The problem is with using jQuery in the custom dsl. What I understood so far is that angular's Scenario Runner runs your app in an iFrame which lies inside a main frame. The main frame has jQuery available, as the Scenario Runner depends on it. So I thought there were no restrictions in using jQuery in a custom dsl. However, the outer jQuery instance cannot bubble up events inside the DOM of the iFrame. So calling ```trigger``` with my custom dsl had no effect inside the iFrame.

Here is what made it work:

{% highlight javascript %}
angular.scenario.dsl('mouseover', function() {
  return function(selector) {
    return this.addFutureAction('Calling mouseover of given element', function($window, $document, done) {
      var elements = $window.angular.element($document.elements());
      elements.trigger('mouseover');
      done();
    });
  };
});
{% endhighlight %}

You can find some explanatory code [here](https://github.com/angular/angular.js/pull/752).