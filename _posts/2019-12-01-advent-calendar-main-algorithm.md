---
layout: post
title: "The Main Algorithm"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 1"
tags: []
---
{% include JB/setup %}

Good December!

The Advent has begun. 

Children are unpacking their advent calendars, opening one small window with a chocolate every day. 
In Java world, we have a [Java Advent Calendar](https://www.javaadvent.com/), in which many authors write a new article every day. 
I also participated in it could of times ([2017](https://www.javaadvent.com/2017/12/flaky-tests.html) and 
[2018](https://www.javaadvent.com/2018/12/wtf-connection-pools.html)).

I also decided to start Selenide Advent Calendar. Every new day a new post. From 1st to 25th December. 
I am starting, and you can continue - just give me a notice by any possible way. 

Today topic is:

# The Main Algorithm

The main feature of Selenide, as many of you say, is _automated waiting_.  
You don't need to copy-paste boilerplate code like `new WebDriverWait(driver, 30).until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[contains(text(),'COMPOSE')]")))` to wait for some event.
You don't need to waste your time and effort to decide where a waiting is needed.
You don't need to see a flaky tests and investigate where you should add one more `new WebDriverWait`. 

With Selenide, everything is much more simple. Any line like `$(byText("COMPOSE")).shouldBe(visible)` **waits automatically** if needed. 

### Doesn't it slower my tests?

No. 

If the element is already visible, Selenide will just go on.
If not - Selenide will wait for 100 ms and check again. If still not, wait for another 100 ms and check again. 
So it will continue up to 4 seconds. 
And only if the element will not appear after 4 seconds, then Selenide will fail the test. 

Of course, those numbers 4s and 100ms are configurable.

### How it works?

We are getting to the Main Algorithm. Actually, it's very simple.  

For example, this is how `$(".btn").shouldBe(visible)` works:

```java
void shouldBeVisible() {
  do {
    try {
      assert webdriver.findElement().isDisplayed() == true;
      return ok;
    }
    catch (Exception e) {
      sleep(100 ms)
    }
  } while (less than N seconds);
  throw new ElementShouldBeVisible("Expected: foo, actually: bar");  // and take a screenshot
}
```  

You see: the idea is really simple. 

In reality, this code [is a bit more complex](https://github.com/selenide/selenide/blob/master/src/main/java/com/codeborne/selenide/impl/WebElementSource.java#L44).
It's because it's "generic" - not only for `shouldBe(visible)`, but for all other methods and conditions.

As you know, 
### the devil is in the details 

In the code shown above, there is plenty of questions:

1. Which exceptions to catch?
   * `Exception`, `Error`, `Throwable`, `AssertionError`, `WebDriverException`? 
2. In case of which exceptions should we stop the waiting and fail the test immediately?
   * for example, if XPath is invalid, it will remain invalid after 4 seconds too.
3. The result is ok or nok?
  * for example, if element is not found - it could be ok for condition `$.shouldNot(exist)`.
4. At what moment would we take screenshot?
5. Can user customize any of these lines?
  * For example, it's probably not needed to take a screenshot because Allure will take its own screenshot anyway. 
  * Or the opposite, we probably should take screenshot and pass it to Allure somehow?
  * (currently both Selenide and Allure take a screenshot, so they are duplicated)
6. What if we run until the last line, and during execution of the last line we got a fu#ng `StaleElementException`?

Our answers to these questions have been changing in time. And will probably change. 
But the essence remains.

## What's now?
I hope you will now understand Selenide waiting instead of perceiving it as a "black magic".
It will probably help you during debugging of some corner cases and mystical test failures. 

And you can even suggest an idea how to improve or simplify the <s>Skynet core</s> Main Algorithm. 

<br>

[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
