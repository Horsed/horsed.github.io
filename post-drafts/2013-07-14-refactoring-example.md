---
layout: post
title: "Refactoring session"
description: "In this post I want to share a refactoring session I had the other day."
category:
tags: webdev javascript refactoring readability jquery handlebars
---
{% include JB/setup %}

In this post I want to share a refactoring session I had the other day. This was actually part of a small hackathon where I collaborated on writing a reponsive web site (which lead to [this article](http://horsed.github.io/2013/07/14/toggling-responsive-layout/)). The project made use of jQuery and [Handlebars](http://handlebarsjs.com/) for templating.


{% highlight javascript %}
function initTemplates(tgContext, fgContext) {  
  var tableSource = $("#table-template").html(),
      table = Handlebars.compile(tableSource),
      $tg = $('#tg').html(table),
      $fg = $('#fg').html(table),
      rowSource = $("#row-template").html(),
      row = Handlebars.compile(rowSource);
  for(var i = 0, len = tgContext.length; i < len; i++) {    
    var $tgRow = $(row(tgContext[i]));
    $tgRow.find('.col-num').text(i+1);
    $tg.find('tbody').append($tgRow);
  }
  for(var j = 0, len2 = tgContext.length; j < len2; j++) {
    var $fgRow = $(row(fgContext[j]));
    $fgRow.find('.col-num').text(j+1);
    $fg.find('tbody').append($fgRow);
  }
}
{% endhighlight %}
