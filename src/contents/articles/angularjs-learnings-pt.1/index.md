---
title: AngularJS learnings pt. 1
author: martin
date: 2013-09-24
template: article.jade
descr: A small detail in the Karma/Jasmine test failure output
---
This might be a continuous topic. I'm learning AngularJS and there are a few things about it that caused some serious WTFs. I'm writing this stuff down to (hopefully) remember it. So here it goes.

### Test output
Ok, this is actually not specific to AngularJS but to Karma/Jasmine. Whenever a test fails due to an unavailable function you get a message like this:

```javascript
TypeError: 'undefined' is not a function (evaluating 'element('form').submit()')
```

Remember: It's the last mentioned function that's ```undefined```! So in this case it is the ```submit``` function.
