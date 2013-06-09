---
layout: post
title: "Using jQuery UI tooltip with Apache Wicket"
description: ""
category: 
tags: webdev wicket behavior jquery jqueryui jwicket wicketstuff
---
{% include JB/setup %}

Several tooltip integrations can be found in [wicketstuffs](http://wicketstuff.org) sub project [jWicket](https://github.com/wicketstuff/core/tree/master/jdk-1.6-parent/jwicket-parent/jwicket-tooltip). I [contributed](https://github.com/wicketstuff/core/wiki/jWicket-UI-Tooltip) an integration of the [jQuery UI tooltip widget](http://api.jqueryui.com/tooltip/) to it. The snapshot release is available through Maven like this:
{% highlight xml %}
<dependency>
  <groupId>org.wicketstuff</groupId>
  <artifactId>wicketstuff-jwicket-ui-tooltip</artifactId>
  <version>6.0-SNAPSHOT</version>
</dependency>
{% endhighlight %}

## What does it do?
Using the jQuery UI tooltip widget, you can create tooltips like this:
{% highlight html %}
<p id="component" title="tooltip content">
  this text will have a tooltip by jQuery UI
</p>
<script>
  $(document).ready(function() {
    $('#component').tooltip({position:{my:'center bottom-20',at:'center top'}});
  });
</script>
{% endhighlight %}
What is there to integrate into Apache Wicket? First of all, you could be wanting to use Wickets JavaScript event system instead of using jQuery's directly. It would also be nice provide the selector, used to apply the widget to an HTML element, dynamically. Also, if there are multiple elements you want to apply the tooltip widget to and the tooltips should all look and behave the same way (that means, they share the same configuration), you will not want to have that JavaScript **for each element**, but instead just once. In the end you want to provide (rich) content for each tooltip. The following JavaScript does all this:
{% highlight javascript %}
Wicket.Event.add(window, "domready", function(event) { 
  $('.componentsWithTooltip').tooltip({
    position: { my: 'center bottom-20', at: 'center top' },
    items: '.componentsWithTooltip',
    content: function() {
      var title = $(this).attr('title');
      if(typeof title !== 'undefined' && title !== false){
        return title;
      } else {
        return $(this).attr('data-tooltip');
      }
    });
  });
});
{% endhighlight %}
This tooltip widget applies to all elements matching the given selector. Their tooltip contents will be obtained from either their **title** attributes or their **data-tooltip** attributes. The latter can contain markup.

You can use [JQueryUiTooltip](https://github.com/wicketstuff/core/blob/master/jdk-1.6-parent/jwicket-parent/jwicket-ui/jwicket-ui-tooltip/src/main/java/org/wicketstuff/jwicket/ui/tooltip/JQueryUiTooltip.java) to generate this JavaScript. Take a look at this example:
{% highlight java %}
// configure tooltips globally
page.add(tooltip_1_10_3(".with-tooltip").setItems(".with-tooltip"));

// static tooltip content from title/data-tooltip attributes
page.add(new Label("component1"));
page.add(new Label("component2"));

// dynamic tooltip content written into data-tooltip attributes
page.add(new Label("component3").add(new JQueryUiTooltipContent("dynamic tooltip content")));
page.add(new Label("component4").add(new JQueryUiTooltipContent(anotherComponent)));
{% endhighlight %}
{% highlight html %}
<div wicket:id="component1" class="with-tooltip" title="tooltip content">...</div>
<div wicket:id="component2" class="with-tooltip" data-tooltip="<strong>tooltip content</strong>">...</div>
<div wicket:id="component3" class="with-tooltip">...</div>
<div wicket:id="component4" class="with-tooltip">...</div>
{% endhighlight %}
The generated JavaScript looks like this:
{% highlight javascript %}
Wicket.Event.add(window, "domready", function(event) {
  $('#component4').attr('data-tooltip',$('#anotherComponent1').html());
  $('.with-tooltip').tooltip({items:'.with-tooltip'});
});
{% endhighlight %}
**JQueryUiTooltip** allows you to use rich tooltip content by putting dynamic content into the data-tooltip attribute of the element having a tooltip. You can provide the content as **String** or even as a **Wicket Component**.

More examples can be found [here](https://github.com/wicketstuff/core/wiki/jWicket-UI-Tooltip#usage).