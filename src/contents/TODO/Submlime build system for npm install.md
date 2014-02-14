---
title: Sublime build system for npm install
author: martin
date: 2014-01-31
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
