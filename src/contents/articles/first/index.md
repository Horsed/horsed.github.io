---
title: Extending Apache Wicket pt. 1
author: martin
date: 2013-06-08
template: article.jade
descr: Building bookmarkable Ajax components with Apache Wicket using the URL fragment
---
Did you ever have had the need build bookmarkable Ajax components with Apache Wicket? Well, Wicket makes it easy to build Ajax components. But one thing they can't do out of the box is manipulating the URL so you can render state to it. And by manipulating the URL I mean writing something to the URL fragment, because that is the only part of the URL you can change with JavaScript whithout causing a page reload by the browser.

With a little bit of JavaScript, making an *AjaxLink*, for example, changing the URL fragment isn't that hard. You could use the *AjaxRequestTarget* to execute the JavaScript, which handles the URL update:
```java
add(new AjaxLink<Void>("link") {
  @Override
  public void onClick(AjaxRequestTarget target) {
    // handle click event
    target.appendJavascript("window.location.hash='#!clickedAjaxLink';");
  }
});
```
That's not too difficult, isn't it? Well, that's not a particularly difficult kind of state to render to the URL. What about rendering state with a key/value layout, e.g. `param1=value1&param2=value2` or `param/value`? You could build URLs that look like this: **http://yoursite.com/#!/email/inbox**.

For this, you would need more JavaScript, because you would want to set/add/remove certain parameters, define constants for the delimiters etc.

What about __reading__ the URL fragment when a page gets requested with fragment state? Since the URL fragment doesn't get sent to the server, you would have to read it after the initial page load and send it to the server (asynchronously). If you have components depending on this state, you would have to initialize them, when the fragment state arrives:
```java
public class MyHomePage extends AsyncUrlFragmentAwarePage {
  public MyHomePage(PageParameters parameters) {
    super(parameters);
    add(new WebMarkupContainer("content").setOutputMarkupId(true));
  }
  @Override
  protected void onParameterArrival(IRequestParameters requestParameters,
    AjaxRequestTarget target) {
    // content based on URL fragment state
    ContentPanel content = new ContentPanel("content", requestParameters);
    content.setOutputMarkupId(true);
    MyHomePage.this.replace(content);
    target.add(content);
  }
}
```

I contributed the [UrlFragment project](https://github.com/wicketstuff/core/wiki/UrlFragment) to [wicketstuff](http://wicketstuff.org), which does all this.
