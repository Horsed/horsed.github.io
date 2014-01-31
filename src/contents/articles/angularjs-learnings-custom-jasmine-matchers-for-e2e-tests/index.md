---
title: AngularJS learnings pt. 3
author: martin
date: 2013-11-02
template: article.jade
descr: Writing a custom Jasmine matcher for your e2e tests
---
How to write a custom Jasmine matcher for yout AngularJS e2e tests

Writing custom matchers in e2e tests differs from the standard [Jasmine way](https://github.com/pivotal/jasmine/wiki/Matchers#writing-new-matchers).

```javascript
angular.scenario.matcher('toBeReallyReallyTrue', function() {
  return this.actual === true;
});
```

You can read more about this [here](https://groups.google.com/forum/#!msg/angular/lcFXW8uv_P8/3gekqCrzSnEJ).