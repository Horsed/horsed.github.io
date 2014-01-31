---
title: AngularJS learnings pt. 2
author: martin
date: 2013-09-28
template: article.jade
descr: Two-way-databinding automatically creates a model if it does not exist
---
Did you know that a two-way-databinding will automatically create a model on the scope when you provide a non existing one?

This is can be tricky, especially when debugging:

```javascript
...
$scope.firstname = 'Alice';
...
```

```html
<input type="text" ng-model="firstName" />
```

Notice that there is a typo in firstname/firstName.