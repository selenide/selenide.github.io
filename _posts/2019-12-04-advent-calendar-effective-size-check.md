---
layout: post
title: "How to check size effectively?"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 4"
tags: []
---
{% include JB/setup %}

Hello!

Today is December 4th, it's the Selenide Advent calendar, and in today's post I will show how to check a collection size effectively.  

# How to effectively check a collection size?

Selenide has convenient methods for checking collections. For example, this is how you can check that a book list contains exactly 3 books:

```java
@Test {
 $$("#books .book").shouldHave(size(3));
}
```

If this page implemented so that it contains much more books, and only some of them are visible, then you can filter the collection:

```java
@Test {
 $$("#books .book").filter(visible).shouldHave(size(3));
}
```

## The problem

If the page contains a lot of books (say, a few dozens or more), this filtration can be slow (say, few seconds and more).  
It's because method `filter(visible)` needs to call `WebElement.isDisplayed()` separately for each element in the
 collection in loop. Every call means a separate call to webdriver, which is a separate http request etc. 
 This all takes times.

Probably tests run 3 days in your project, and few seconds don't really play any role. Then you can skip this post. :) 

But if you care about effectiveness of your tests, go on.  

## The first try

How to speed up this check? The first idea is to filter elements right in the selector:

```java
@Test {
 $$("#books .book:visible").shouldHave(size(3));
}
```

But this selector doesn't work. 

The problem is that there is no CSS selector `:visible`. It doesn't exist. Only JQuery can understand it. 


## The second try

Who saves us? Of course, JavaScript!

You can create a helper method which finds a number of visible element (with a help of JavaScript and JQuery):

```java
private int sizeOf(String cssSelector) {
  Number count = executeJavaScript("return $(arguments[0]).length", cssSelector);
  return count.intValue();
}
```

(this code only works if the page contains JQuery library. If not, you can write a similar code using some other JavaScript library.)

Now your check will be fast because it calls WebDriver method only once. And browser executes any JavaScript very quickly.

```java
@Test {
  assertEquals(1, sizeOf(".offer:visible"));
}
```


## What's now?

Learn the power of JavaScript.   
It allows many other tricks which can make your tests more fast and stable. 

<br/>


<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
