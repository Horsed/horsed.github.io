---
title: Sublime build system for npm install
author: martin
date: 2014-02-17
template: article.jade
descr: How to execute npm install with Sublime Text
---

I recently used Sublime Text's build system to execute ```npm install```. There is a nice overview of simple but powerful build systems [here](http://addyosmani.com/blog/custom-sublime-text-build-systems-for-popular-tools-and-languages/) by [@addyosmani](https://twitter.com/addyosmani). My ```npm``` task is just as simple and looks like this:

```js
{
  "cmd": ["npm", "install"],
  "working_dir": "${file_path}",
  "shell": true
}
```

This will execute ```npm install``` inside the directory of the currently open file. NPM will find the next ```package.json``` upwards your directory tree. Be aware that NPM errors will produce a ```npm-debug.log``` inside the directory it was used in. This could be annoying.

If you want to execute ```npm install``` inside the currently open project directory you could set the ```working_dir``` to the following:

```js
{
  "cmd": ["npm", "install"],
  "working_dir": "${project_path}",
  "shell": true
}
```

Have fun npm-installing!
