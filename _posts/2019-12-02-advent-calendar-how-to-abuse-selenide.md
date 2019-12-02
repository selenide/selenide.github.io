---
layout: post
title: "How to abuse Selenide"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 2"
tags: []
---
{% include JB/setup %}

Good year!

It's December, 02, and we continue with our Selenide Advent Calendar. This time will talk about invalid use of Selenide.

# How to abuse Selenide

I often hear people complaining that the following code doesn't catch the exception:

```java
try {
  $(".banner").shouldBe(visible);
  $(".banner .close").click();
}
catch (Exception e) {
  // System.out.println("The element is not found - a banner hasn't appeared this time.");
}
```

The intention of this test is to check if a banner appeared. Not immediately, but wait for the banner a little bit: probably it will appear after some time.
If the banner has appeared, the test needs to close it.

<br/>

# Why this is a bad test?

Because **it's slow**.

In most cases, banner will not appear, and the test will waste 4 seconds (or what is your timeout).

It's awful. Are you a professional engineer? Your goal is to make your tests fast and stable. 

<br/>

# Why this test is very bad?

Because  **it's unstable**.

Sometimes banner will appear in the end of 4th second. 
Test decides that banner hasn't appeared and goes on. At this moment the banner appears. Ups, you get a flaky test. 

<br/>

# Why this test is very-very bad?

Because **it doesn't test the banner**. 

1. Imagine that banner hasn't appeared during tests run. All tests are green.
But in production, the banner appears for end-users. And when the banner appears, an error happens. The application crashes. Users complain. <br/> <br/> 
  _But your tests are green._

2. Imagine the opposite. During your tests run, banner appears all the time.  Well, that’s what happened in the test environment.
But real users see the banner very rarely, and the error happens when they don't see the banner. The application crashes. Users complain. <br/> <br/>
  _But your tests are green._

<br/>

# What can you do?

Obviously, you should have at least 2 tests: 
1. Case when the banner appears, and
2. Case when the banner doesn't appear.

To achieve that, you need a possibility to rule the banner. You should be able to show or hide the banner either 
using some API or admin console or by running SQL in database. Whatever. Every mean is good. 
If you don't have such API, you should make a deal with developers and create it. 

Don't tell me that you can't. Are you a professional engineer or what? 

If you cannot, just delete this test. Cannot means CAN NOT.

<br/>

And finally, the initial question:
# Why that code doesn't catch the Exception?

You probably guessed it, right? 

The trick is with hierarchy of Java exceptions. The parent class of all java exceptions is `Throwable`, not `Exception`.
Here is the hierarchy: 

* `Throwable`
  * `Exception`
    * `RuntimeException`
      * `WebDriverException`
  * `Error`
    * `AssertionError`
      * `UIAssertionError`
        * `ElementShould`

This is the reason why you miss all `Error` subclasses (including Selenide errors) when you `catch (Exception e)`.

You might think: "Great, I will `catch (Error e)`". No. NO! Please, NO! 

Read the `java.lang.Error` javadoc: 

> An Error is a subclass of Throwable that indicates serious problems that a reasonable application **should not try to catch**. 
> Most such errors are abnormal conditions.

## What's now?

I hope you will stop catching exceptions in tests. The goal of tests is to report errors, not catch them. 

I hope you will take the test environment under your control. 

You need to decide, either you rule the banner, or the banner rules you.

Either you automate tests, or tests automate you.

<br>

[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
