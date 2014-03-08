---
title: Toggling responsive layout
author: martin
date: 2013-07-14
template: article.jade
descr: How to enable and disable responsive CSS rules
---
Implementing a responsive layout means dealing with multiple screen resolutions and devices in order to provide users an optimal viewing experience. However, it's common to link to the desktop version of a page if it doesn't provide a complete and mobile friendly layout. While this might be OK for stateless pages, it would definitely be a showstopper in some stateful use cases.

Switching between desktop and mobile layouts dynamically without a page reload can be achieved by simply using a conditional CSS class on a top element like ```body```:

```html
<body class="fluid">
  <div class="container">lorem ipsum...</div>
</body>
```

Consider the following CSS rules:

```css
.container { width: 820px; }               // fixed-width layout

@media only screen and (max-width: 820px) {
  .fluid .container { width: 100%; }       // fluid layout
}
```

For this example, switching the layout means removing the ```.fluid``` class with a little bit of JavaScript/jQuery:

```javascript
$('#link-to-desktop-version').click(function() {
  $('body').removeClass('fluid');
});
```

This enables users to switch to a fixed-width layout by clicking the corresponding link. With a little more jQuery the link could even toggle back ```.fluid```.

The layout state could even be saved in the URL fragment or in a cookie, so the user won't switch back to the fluid layout by reloading the page.
