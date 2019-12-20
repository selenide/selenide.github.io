---
layout: post
title: "Big “wait” theory"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 20"
tags: []
---
{% include JB/setup %}

# Big "wait" theory

The topic of "wait" mechanism is well-known and sometimes can be controversial.  
The fact is that modern websites are problematic to be tested by test automation frameworks and generate many situations 
where standard Selenium methods are ineffective. If you have read Selenide documentation, you already know that classic explicit waits like:

```java
element = (new WebDriverWait(driver, <timeOutForElement>))
  .until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(<cssSelector>)));
```

or
```java
element = (new WebDriverWait(driver, <timeOutForElement>))
  .until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(<cssSelector>)));
```

have been replaced by Selenide with (way shorter) variants:

```java
element = $(<cssSelector>).should(exist);
element = $(<cssSelector>).shouldBe(visible);
```

**As we know assertions in Selenide are new version of explicit wait, which is well-described for example in [documentation](https://selenide.org/documentation.html).**

Today we won’t be looking at assertions and wait mechanism from the technical point of view, but we will think about good ideas and examples of using particular assertions in different situations. 

## Modern problems require modern solutions
 
### 1. `Thread.sleep()`

This is the worst possible thing, that could happen to our tests in Selenium.
 
Some situations just required to use it, and there were no other solutions to move forward. 
Sometimes QAs try to use it to wait for some page to load, sometimes they try to wait for some element when other 
waits fail. Unfortunately, this way we can lose a lot of time. 
If we use it only in one test, it’s not that dangerous cause it will take probably around 4 seconds of our time. 
But if we use it in 150 tests, it will substantially increase the time of performance. 
There is no need to explain why it’s a bad thing. 
Although `sleep()` is still available in Selenide, smart assertions mentioned before make it useless in sense of 
waiting for anything on the page. Check next points.

### 2. How to wait for page to load?
 
The easiest way is to choose some element from the page that we want to load and use Selenide method:

```java
$(cssSelector).shouldBe(visible);
```

Notice that Selenide will try to find the element first, and then it will wait for the element to be visible. 
If it has not found the element it means that the page hasn’t loaded.

Also, we can designate some element from the page that we are leaving and use method:

```java
$(element).should(disappear);
```

This way we create double-check for moving from one page to another, even if it takes a lot of time and previously we needed `Thread.sleep()`.

### 3. Changing state of an element

It happens that we want to validate the state of an element that changes depending
on actions taken by user. For example, element contains text informing us if some file has been uploaded or not. 
It is possible that we will upload the file but it will take some time to change the state of element, because 
back-end has to process the task and give back the information. 

Normally in our test we would like to upload file and 
check the state of an element to make sure that action succeeded. But how do we know when the element will change its state? 
The uploading and processing time can be different depending on the file’s size. 
This is the moment where a lot of people would use `Thread.sleep()` if standard Selenium methods failed(it really 
happens, sometimes Selenium checks the state of some element and thinks that it’s just wrong). 

With Selenide, we have a very smart tool for this purpose:

```java
element = $(cssSelector).shouldHave(exactText(<expectedText>));
```

This way Selenide will wait for the default timeout period for the element to change its state. We can check it with no additional lines of code and we can be sure that Selenide will really wait for it. 

### What's next?

These are just very basic ideas and examples on how to “wait” with Selenide. There are many more ways of doing it, and the fact is that now we have a lot of powerful tools to write our tests with real and effective waits that don’t need to be fixed with additional “sleeps”. It’s up to you what assertions will be added to your tests. Just make it smart and don’t waste the time, it’s a valuable thing :) 


Maciej Grymuza (figrym@gmail.com)

