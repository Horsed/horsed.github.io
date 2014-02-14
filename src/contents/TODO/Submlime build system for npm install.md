---
title: Sublime build system for npm install
author: martin
date: 2014-02-14
template: article.jade
descr: How to use Sublime's build system to execute npm install in your current working directory
---
```js
{
  "cmd": ["npm", "install"],
  "working_dir": "${file_path}",
  "shell": true
}
```
* executes npm install in the directory of your currently opened file
* ```npm-debug.log```