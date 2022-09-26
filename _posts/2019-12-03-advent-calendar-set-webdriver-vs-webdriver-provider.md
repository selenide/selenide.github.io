---
layout: post
title: "setWebDriver or WebDriverProvider?"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 3"
tags: []
---
{% include JB/setup %}

Good evening!

Today is December 3rd, you are reading the Selenide Advent calendar, and in today's post I will answer one simple question.  

# Which one should I choose, `setWebDriver()` or `WebDriverProvider`?

As you know, Selenide opens a browser automatically and closes it at the right moment. You don't need to care about the browser. 

But sometimes you want to open a "custom" browser with some specific settings.
Selenide has 2 methods for this.
It happened so that I never wrote anywhere how to choose one of them.

So,

#### Option 1:

```java
  Configuration.browser = MyWebdriverProvider.class.getName();
``` 

This option is preferred in most cases. It's good because class `MyWebdriverProvider` is only responsible for HOW to open a browser
(which options to pass, where to find binaries etc). But is not responsible for WHEN to open and close the browser. Selenide takes care of it.

#### Option 2: 

```java
@Before
public void setUp() {
  var yandexBrowser = new YandexDriver(...);
  WebDriverRunner.setWebDriver(yandexBrowser);
}
``` 

This option is worse because you are responsible not only for opening, but also for close the browser. This often causes misunderstanding. 
Selenide cannot close the browser because you might use it somewhere else. You open it - you close it.


This begs the question:

### Why it's needed at all?

Initially method `setWebDriver()` was created to enable easy adoption of Selenide in existing projects (without re-writing the existing codebase).

Imagine that company X already has a lot of automated tests on Selenium (or HtmlElements, Thucydides, Serenity or anything else).
They want to write new tests on Selenide, but leave existing tests untouched. 

Apparently they already have a code snippet in their codebase which opens and closes the browser. They want to say Selenide
to use the same browser. That's when method `setWebDriver()` is useful. It allows you to run the old and the new code all together,
so that it works in the same browser.

As you see, the use of method `setWebDriver()` is rather narrow. I’m not sure at all if it was ever used in that vein. :)

## What's now?

If you are writing a new project, use `WebDriverProvider`. SRP. 

<br/>

# UPD {#driver-factory}
Later in [Selenide 5.16.1](https://ru.selenide.org/2020/11/25/selenide-5.16.2/#selenide-5.16.2) we added one more option `DriverFactory`.
Now it's the recommended way to create a customized webdriver.

The idea is very similar to `WebDriverProvider`, but gives you more control over webdriver options. 
You need to
1. either implement interface `DriverFactory`,
2. or create a subclass of [ChromeDriverFactory](https://github.com/selenide/selenide/blob/master/src/main/java/com/codeborne/selenide/webdriver/ChromeDriverFactory.java),
   [FirefoxDriverFactory](https://github.com/selenide/selenide/blob/master/src/main/java/com/codeborne/selenide/webdriver/FirefoxDriverFactory.java)
   or similar class (which exist in Selenide and implement interface `DriverFactory`) and override only needed methods. 
   All methods in these classes are made small and declared protected. 

You can find examples in [Selenide own tests](https://github.com/selenide/selenide/blob/master/statics/src/test/java/integration/ChromeProfileByFactoryTest.java).

See also [blog post from Boris Bay](https://mbbaig.blog/selenide-webdriverfactory/).



<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
