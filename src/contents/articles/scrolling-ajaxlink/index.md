---
title: Scrolling AjaxLink
author: martin
date: 2013-07-01
template: article.jade
descr: Making an AjaxLink scroll top of the page
---
I recently came across a browser quirk: A Wicket AjaxLink was supposed to scroll the page to the top after it was clicked. But it didn't...

Here is the code:
```java
add(new AjaxLink<Void>("link") {
  @Override
  public void onClick(AjaxRequestTarget target) {
    // handle click event
    target.appendJavaScript("$('html, body').animate({scrollTop: 0}, 100);");
  }
});
```
```html
<a wicket:id="link">click me</a>
```

If you don't provide a href attribute, the anchor will be rendered with a href value of <i>#</i>:
```html
<a href="#">click me</a>
```

Now the problem with this is, that if you click on that link (seen in IE 8, 9 and Firefox), the browser <strong>might</strong> not scroll to the top of the page but to the link (which was not what I wanted). I think this is due to a race condition based on the asynchronous parts of the <i>animate</i> method and other JavaScript snippets coming with the AJAX repsonse. It seems to me, that browsers differ in the execution timings of these snippets, especially when there are asynchronous parts involved.
I played around with the <i>duration</i> option of the <i>animate</i> method and tried to delay it with jQuery's <i>delay</i> method. This had different effects in different browsers, of course. The only thing that really helped me, was making the <i>AjaxLink</i> a <i>span</i> (or something other than an anchor):

```html
<span style="cursor:pointer;cursor:hand;">click me</span>
```

With this, no browser will try to jump anywhere and jQuery scrolls the page to the top.
