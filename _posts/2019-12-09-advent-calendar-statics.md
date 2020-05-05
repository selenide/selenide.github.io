---
layout: post
title: "Why we banned statics and then allowed again?"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 9"
tags: []
---
{% include JB/setup %}

Good evening!

Here is the 9th day of Selenide Advent Calendar, and  
I’ll tell you what excites the public most of all.    

# Why statics were banned in Selenide 5.0.0, but allowed again in 5.4.0?

Short answer: we banned them occasionally. But it was good.

Let me explain it in detail :)


### How Selenide holds WebDrivers

Selenide stores webdriver instances in ThreadLocal.  
It allows you to run tests in parallel: different threads get different webdrivers. The code looks like this: 

```java
class WebDriverRunner {
  private static final ThreadLocal<WebDriver> webdriver = new ThreadLocal<>();
  private static final ThreadLocal<SelenideProxyServer> proxy = new ThreadLocal<>();
}

```

Say, method `$("a").click()` works like this:

```java
  WebDriverRunner.webdriver.get().findElement("a").click();
```

## Briefly about SelenideDriver

But ThreadLocal implies one limitation: you cannot use two webdrivers in one thread  
(as well as one webdriver in two threads - but aren't there yet).

We planned to solve this problem in Selenide 5.0.0. We created a special class `SelenideDriver`, that allowed you to use 
 two webdrivers in one test:

```java
SelenideDriver browser1 = new SelenideDriver();
SelenideDriver browser2 = new SelenideDriver();

browser1.open("https://google.com");
browser2.open("http://yandex.ru");

browser1.$(h1).shouldHave(text("Google"));
browser2.$(h1).shouldHave(text("Yandeks"));
```

It forces us to do a major refactoring: we removed all usages of old good static method `open()`, `$` and `$$` 
inside Selenide itself. Every piece of Selenide code that needs a webdriver now gets a `SelenideDriver` parameter.  
Yes, we had to pass this parameter everywhere...  


## Here comes the question

What should we do with old good static methods `open()`, `$` and `$$`? They have to get `SelenideDriver` instance somewhere.
Where to take it from?


## Selenide 5.0.0: Statics got a punch

We added to class `WebDriverRunner` a third ThreadLocal:

```java
  private static final ThreadLocal<SelenideDriver> selenideDriver = new ThreadLocal<>();
```

Briefly, `SelenideDriver` is a simple class with two fields `WebDriver` and `SelenideProxyServer`.  
In general, it worked and solved the initial problem.   

What I could not have envisioned at that moment was that so many folks defined their web elements in static fields:

```java
public class MyPageObject {
  public static SelenideElement fname = $("#fname");
  public static SelenideElement lname = $("#lname");
}
```

And re-open the webdriver between tests.


### One important detail:
We did one more improvement in Selenide 5.0.0.

Before 5.0.0, Selenide automatically opened a new browser if it wasn't opened yet. At any moment.   
Sometimes it caused perplexity because browser opened at unexpected moments (for example, when trying to log an error 
caused by a crashed browser). 

Of course, it happened because of bad tests. Bug after all, _we created Selenide to help people, right?_  

That's why starting from version 5.0.0, Selenide didn't occasionally open a browser anymore.  
Instead, it said: "There is no an opened browser, I cannot do my job. You need to call method `open()` first."


### And what failed then?


The coincidence of these two factors led to the following problem:
1. Test creates a static field `static SelenideElement fname = $("#fname")`.
2. This `fname` remembers a `SelenideDriver` it was created with. 
3. Test closes the browser in the end. 
4. A following test opens a new browser tries to use static field `fname`.
5. And `fname` calls its own instance of `SelenideDriver` it was created with.
6. And fails, because _that_ `SelenideDriver has been closed. 

More than a year - from September, 2018 to October, 2019 - I was trying to explain that static variables are evil.  
I even created a special talk ["Antistatic"](https://www.youtube.com/watch?v=dFQSOlOOoXE&list=PLfazdZ9SzB9eDJIugtfH7KeVLLAP1pDLh) (yes, this time in English:)).  

But finally I gave up. Because it would be too big refactoring for many folks to rewrite their projects from static variables.
  
After all, _we created Selenide to help people, right?_


## Selenide 5.4.0: Statics won 

How we finally solved this problem?

The solution is quite simple. We replaced `ThreadLocal<SelenideDriver>`  by a static variable (yep :))

```java
private static final SelenideDriver = new ThreadLocalSelenideDriver();
``` 

Now this "static" `SelenideDriver` is a singleton. It always exists. It's never closed. All static `SelenideElement` 
 variables created with it will live forever. But it also doesn't hold fields `WebDriver` and `SelenideProxyServer`.
  It fetches them from `WebDriverRunner`'s ThreadLocals every time. 

  
  
### P.S.
That's why method `WebDriverRunner.getSelenideDriver()` disappeared in Selenide 5.4.0.

I was surprised that many people have already managed to use it. People, I do not understand you! _How do you manage to use everything so wrong?_  
Well, it was my mistake to make this method public. But I never mentioned it in any of my posts nor documentation. 
I never recommended to use. How could someone decide to use it? How this magic happens?
 
## What's now

We returned the possibility to declare your `SelenideElement`s in static fields. 
  
But please do not abuse it.   

I still don't like it :)

<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
