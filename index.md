---
layout: front-page
title: 
tagline: web dev
---
{% include JB/setup %}

## older posts
{% for post in site.posts %}
{{ post.date | date_to_string }} &raquo; [{{ post.title }}]({{ BASE_PATH }}{{ post.url }})
{% endfor %}