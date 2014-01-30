---
title: Fetching bower packages via a RESTful API
author: martin
date: 2014-01-30
template: article.jade
---
When starting to use [AngularJS](http://angularjs.org/) at work, I soon had to realize, that using [Bower](http://bower.io/) might not be an option. Bower fetches components from [GitHub](https://github.com) with ```SSH```, which got blocked by the corporate proxy. If Bower was able to fetch with ```HTTPS```, everything would have been fine. Of course, easing the security restriction was not an option :-)  
Instead of arguing about the proxy and why Bower didn't seem to have a proxy configuration, I quickly hacked together a simple Node webapp to fetch Bower components with. It runs on [heroku](https://www.heroku.com/). The idea was to ```curl``` a component from that webapp, which then actually fetches the component via [Bower's API](http://bower.io/#programmatic-api) and zips it. I curled and unziped via a shell script. Pretty simple. The only thing missing was automatically editing the ```bower.json```, which doesn't seem too difficult.  
The hardest part about that webapp was making it failsafe. The earliest versions crashed when Bower threw an error (like it does when you request a component that doesn't exist) and I'm not sure why, but I wasn't able to catch those errors. I learned about Node's [domain module](http://nodejs.org/api/domain.html) which was kind of hard figure out at first but really helped with the error handling.  
I'm not using the app today anymore, nor am I coding on it. It was just one of a few small projects I started to do something that is new and interesting at least for 2 or 3 evenings.  
Anyway, here is some code about that tricky error handling with nested ```domains```:

```javascript
var search = bower.commands.search(packageName, {});

var d = domain.create();
d.on('error', function(err) {
  errFn(err);
});
d.add(search);

d.run(function() {
  search.on('end', function (results) {
    if(results.length > 0) {
      var install = bower.commands.install(
        packageName,
        {save:false},
        {cwd: "output", directory: "bower_components"});

      var d = domain.create();
      d.on('error', function(err) {
        errFn(err);
      });
      d.add(install);

      d.run(function() {
        install.on('end', function(installed) {
          // do something            
        });
      });
    } else {
      errFn('package ' + packageName + ' not found');
    }
  });
});
```

The ```bower.commands``` ```search``` and ```install``` are ```EventEmitters``` and in this example ```install``` is created inside an event handler of ```search```. Using ```domain``` for error handling requires you to add all ```EventEmitters``` being used inside the ```domain.run(function() {})``` function to the domain **before** the run function gets set. ```install``` is created inside of ```search.on('end',...``` which in turn is executed in the outer ```domain```. That means, ```install``` can't be added to the outer domain anymore. It has to be used inside another ```domain```. That's why there is an inner ```domain```.