---
title: Using jQuery UI tooltip with Apache Wicket
author: martin
date: 2013-06-09
template: article.jade
---
There are several integrations of tooltips based on JavaScript libraries in the wicketstuff sub project jWicket. I contributed jWicket-UI-Tooltip to it, an integration of the jQuery UI tooltip widget.

You can find it [here](https://github.com/wicketstuff/core/wiki/jWicket-UI-Tooltip). The snapshot release is available through Maven like this:
```xml
<dependency>
  <groupId>org.wicketstuff</groupId>
  <artifactId>wicketstuff-jwicket-ui-tooltip</artifactId>
  <version>6.0-SNAPSHOT</version>
</dependency>
```

## What does it do?
Using the jQuery UI tooltip widget, you can create tooltips like this:
```html
<p id="component" title="tooltip content">
  this text will have a tooltip by jQuery UI
</p>
<script>
  $(document).ready(function() {
    $('#component').tooltip({position:{my:'center bottom-20',at:'center top'}});
  });
</script>
```
[JQueryUiTooltip](https://github.com/wicketstuff/core/blob/master/jdk-1.6-parent/jwicket-parent/jwicket-ui/jwicket-ui-tooltip/src/main/java/org/wicketstuff/jwicket/ui/tooltip/JQueryUiTooltip.java) is a Wicket Behavior that generates the JavaScript neccessary to create tooltips. It offers an API to configure the tooltip(s). Here are some features:
* the generated JS uses Wickets JavaScript event system instead of using jQuery's directly
* the default selector is the markup id of the component, the JQueryUiTooltip was added to, or `document` when it was added to a page
* one tooltip configuration for multiple elements having tooltip: add JQueryUiTooltip to the page and/or provide a custom jQuery selector, then just add **JQueryUiTooltipContent** to these components
* **JQueryUiTooltipContent** allows you to provide markup as tooltip content

## Example
```java
// configure tooltips globally
page.add(tooltip_1_10_3(".with-tooltip").setItems(".with-tooltip"));

// static tooltip content from title/data-tooltip attributes
page.add(new Label("component1"));
page.add(new Label("component2"));

// dynamic tooltip content written into data-tooltip attributes
page.add(new Label("component3").add(new JQueryUiTooltipContent("dynamic tooltip content")));
page.add(new Label("component4").add(new JQueryUiTooltipContent(anotherComponent)));
```
```html
<div wicket:id="component1" class="with-tooltip" title="tooltip content">...</div>
<div wicket:id="component2" class="with-tooltip" data-tooltip="<strong>tooltip content</strong>">...</div>
<div wicket:id="component3" class="with-tooltip">...</div>
<div wicket:id="component4" class="with-tooltip">...</div>
```
The generated JavaScript looks like this:
```javascript
Wicket.Event.add(window, "domready", function(event) {
  $('#component4').attr('data-tooltip',$('#anotherComponent1').html());
  $('.with-tooltip').tooltip({items:'.with-tooltip'}, ...);
});
```
**JQueryUiTooltipContent** allows you to use rich tooltip content by putting dynamic content into the **data-tooltip** attribute of the element having a tooltip. You can provide the content as **String** or even as a **Wicket Component**.

More examples can be found [on the wiki page](https://github.com/wicketstuff/core/wiki/jWicket-UI-Tooltip#usage).

Links:
* [wicketstuff](http://wicketstuff.org)
* [jWicket](https://github.com/wicketstuff/core/tree/master/jdk-1.6-parent/jwicket-parent/jwicket-tooltip)
* [jWicket-UI-Tooltip](https://github.com/wicketstuff/core/wiki/jWicket-UI-Tooltip)
* [jQuery UI tooltip widget](http://api.jqueryui.com/tooltip/)
