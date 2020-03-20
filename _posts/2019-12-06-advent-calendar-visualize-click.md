---
layout: post
title: "How to visualize click"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 6"
tags: []
---
{% include JB/setup %}

Good evening!

Today is December 6th, you are reading the Selenide Advent calendar, and in today's post I will show one simple 
technique how to catch some flaky tests.  


# What's wring with clicks?

It's an eternal problem: flaky tests.
One of typical reasons of flaky tests: click doesn't work.

As i described [in this video](https://www.youtube.com/watch?v=ibx8nVvt-Js) on DelEx 2019 conference (sorry, the video is in Russian),
 click in selenium often doesn't work if the element was moving or resizing at that moment. Or if it was covered by other element
 that suddenly appeared and got the click. 

### Why Selenide hasn't solved it already?

A global solution could be like this: method `$.click()` waits for completion of any animations and movements before actually performing the click.
Currently Selenide doesn't have such a solution. I guess it's impossible to make such waiting universal. 
All projects are different, with different frameworks and designs. If you have an idea how to implement such a waiting - 
feel free to drop me a notice. 

But what we can is to highlight the element that actually got the click. It will not solve the problem entirely,
but at least it helps to localize the problem.

### How to highlight the element?

You can add the following JS code to your application.  
It listens for all click events on the page and adds highlights with a green border the element that actually got the click.  
It will help you to detect cases where a wrong element got the click.

```java
#{if test}
    <script>
      function onClick(event) {
        var e = event || window.event;
        var target = e.target || e.srcElement;
        target.style['box-sizing'] = 'border-box';
        target.style['border'] = '2px solid green';
      }
    
      document.addEventListener('click', onClick);
    </script>
#{/if}
```

You might need to adjust this code to your needs: it depends on your application, framework, design etc.

Here you can see one example of possible solutions: [Highlighter](https://github.com/selenide-examples/gmail/blob/master/test/org/selenide/examples/gmail/Highlighter.java).

## What's now?

If you have flaky test (as all of us), you can start from this step.  
At least you will see which element got the click. 

<br/>


<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
