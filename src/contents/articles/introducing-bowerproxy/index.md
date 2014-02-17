---
title: bowerproxy
author: martin
date: 2014-01-30
template: article.jade
descr: A webapp that fetches Bower components.
---
When starting to use [AngularJS](http://angularjs.org/) at work, I soon had to realize, that using [Bower](http://bower.io/) might not be an option. Bower fetches components from [GitHub](https://github.com) with ```SSH```, which got blocked by the corporate proxy. If Bower was able to fetch with ```HTTPS```, everything would have been fine. Of course, easing the security restriction was not an option :-)

Instead of arguing about the proxy and why Bower didn't seem to have a proxy configuration, I quickly hacked together a simple Node webapp to fetch Bower components with. It runs on [heroku](https://www.heroku.com/). The idea was to ```curl``` a component from that webapp, which then actually fetches the component via [Bower's API](http://bower.io/#programmatic-api) and zips it:

```$ curl http://bowerproxy.herokuapp.com/install/lodash -O --proxy http://xxx:xxx --proxy-ntlm --proxy-user 'xxx:xxx' > lodash.zip```

You can also specify the version number:

```$ curl http://bowerproxy.herokuapp.com/install/lodash/2.4.1 -O --proxy http://xxx:xxx --proxy-ntlm --proxy-user 'xxx:xxx' > lodash.zip```

The only thing missing is automatically editing a ```bower.json``` in the working directory.

The hardest part about that webapp was making it failsafe. The earliest versions crashed when Bower threw an error (like it does when you request a component that doesn't exist) and I'm not sure why, but I wasn't able to catch those errors. I learned about Node's [domain module](http://nodejs.org/api/domain.html) which was kind of hard figure out at first but really helped with the error handling.

I'm not using the app today anymore, nor am I coding on it. It was just a small project I started to do something that is new and interesting at least for 2 or 3 evenings.