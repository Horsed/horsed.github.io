---
title: Toggling responsive layout
author: martin
date: 2013-07-14
template: article.jade
---
Implementing a responsive layout means dealing with multiple screen resolutions and devices in order to provide users an optimal viewing experience. One therefore serves all CSS and markup for all provided viewports within the same page. However, there are some cases where one cannot or doesn't want to provide a mobile friendly layout. To deal with that, some companies/sites offer links to a desktop version of a particular page or the homepage. But how to do that, when making use of responsive design techniques?

There is a nice solution for switching between the desktop and mobile layout dynamically, even without a page reload, since all layouts already lie in the page. Since RWD [emphasizes a mobile first approach](http://en.wikipedia.org/wiki/Responsive_web_design#Mobile_first.2C_unobtrusive_JavaScript.2C_and_progressive_enhancement), a responsive layout is responsive by default. One would have to switch to a fixed/desktop layout.
Consider the following responsive CSS snippet:

```css
.container {
  width: 820px;
  margin: 0 auto;
}
@media only screen and (max-width: 820px) {
  .container.flexible {
    width: 100%;
  }
}
```

An element with a CSS class ```container``` should have a fixed ```width``` of 820px on desktop screens but should have a relative ```width``` when rendered on a smaller screen. As you can see, the 2nd CSS selector matches only elements with CSS classes ```container``` and ```flexible```. Here is the corresponding markup:

```html
<div class="container flexible f">lorem ipsum...</div>
```

The responsiveness defined in the CSS snippet is based on the logical conjunction of ```(max-width: 820px)``` and ```.flexible```. To turn off the flexibile ```width``` one just needs to remove the CSS class ```flexible``` with a little bit of JavaScript/jQuery:

```javascript
$('#link-to-desktop-version').click(function() {
  $('.f').each(function(index) {
    $(this).removeClass('flexible');
  });
});
```

The click handler removes the CSS class ```flexible``` from all elements with the CSS class ```f```. ```f``` is a marker for all elements that need to be considered for the responsiveness.
Now users can switch to a desktop layout by clicking the corresponding link. With a little more jQuery the link could even toggle back ```flexible```. One could furthermore save the state in the URL fragment or in a cookies, so the user doesn't switch back to the flexible layout by reloading the page.
