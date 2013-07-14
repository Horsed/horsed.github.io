---
layout: post
title: "Refactoring session"
description: "In this post I want to share a refactoring I made the other day."
category:
tags: webdev javascript refactoring readability jquery handlebars
---
{% include JB/setup %}

It was part of a small hackathon where I collaborated on writing a responsive web site (which actually lead to [this article](http://horsed.github.io/2013/07/14/toggling-responsive-layout/)). The site contained two tables which were built using templating and JSON data. We made use of jQuery and [Handlebars](http://handlebarsjs.com/) for templating and it didn't take long for the initialization of templates to end up in an _inline_ styled method like this:

{% highlight javascript %}
function buildTables(tgContext, fgContext) {
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

  for(var j = 0, len2 = fgContext.length; j < len2; j++) {
    var $fgRow = $(row(fgContext[j]));
    $fgRow.find('.col-num').text(j+1);
    $fg.find('tbody').append($fgRow);
  }
}
{% endhighlight %}

What this function does is, it creates a template for a table, puts it into two DOM elements (```#tg``` and ```#fg```), creates a template for a table row and append it to the table bodies for each array element given by ```tgContext``` and ```fgContext```.
I wanted to make this as declarative as possible but I don't think the above function achieves that goal. In fact, the multiple levels of abstraction throughout the entire function destroy readability. Let's make this cleaner.

First we'll try to extract some methods (I don't even have unit tests for this although it would have been pretty easy to set some up since the whole project was written using [jsbin](http://jsbin.com). Let's pretend I do have tests ;-)).

{% highlight javascript %}
function buildTables(tgContext, fgContext) {  
  initTemplates(tgContext, fgContext, function($tg, $fg, row) {
    addRowsTo($tg, row, tgContext);
    addRowsTo($fg, row, fgContext);
  });
}

function initTemplates(tgContext, fgContext, cb) {  
  var tableSource = $("#table-template").html(),
      table = Handlebars.compile(tableSource),
      $tg = $('#tg').html(table),
      $fg = $('#fg').html(table),
      rowSource = $("#row-template").html(),
      row = Handlebars.compile(rowSource);  
  cb($tg, $fg, row);
}

function addRowsTo($table, row, data) { 
  for(var i = 0, len = data.length; i < len; i++) {    
    var $row = $(row(data[i]));
    $row.find('.col-num').text(i+1);
    $table.find('tbody').append($row);
  }
}
{% endhighlight %}
