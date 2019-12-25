---
layout: post
title: "JavaScript tricks"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 24"
tags: []
---
{% include JB/setup %}

Good Christmas!

Today is December, 24. It's Christmas. It's the last day of our Selenide Advent Calendar. 

In this last day, we will play JavaScript.  

As a language, JavaScript is a disaster, but it gives a big power when used in automated tests.  
It allows you doing things that are impossible with pure WebDriver. 

Let me show few examples from real projects.  

## Pick a date

There is a lot of different "date pickers" out there. It's always a headache to pick a date using them.  

How to pick a date in your test?

```java
@Test {
  setDateByName("recurrent.startDate", "16.01.2009");
}
``` 

A straightforward way could be like this:
1. Click a "calendar" icon
2. Click a year number
3. Click "previous month" arrow (how many times?)
4. Click a day
5. Ooops, today is February, 29. The test failed.  

This way is **slow and unstable**. 

<br/>

#### And this is how it can be implemented using JavaScript:

```java
void setDateByName(String name, String date) {
  executeJavaScript(
    String.format("$('[name=\"%s\"]').val('%s')", 
    name, date)
  );
}
```

It's **fast and stable**.

You might be confused because it's not the "real" way. We will discuss it in the end. Hold on. 

## Hide the calendar

Assuming that the calendar was opened, how to close it?

A straightforward solution would be to click the "cross" in the corner of calendar modal dialog. Again, it's slow and unstable:
* the "cross" is always located in different corners
* location of the "cross" can change depending on design, browser size etc.
* sometimes calendar popup is opened slowly - you need to add explicit wait for the "cross" to immediately close it. 

The idiotic situation.

<br/>

#### It can be done much easier with JavaScript:

```java
executeJavaScript(
  "$('.datepicker').hide();"
);
```

It's **fast and stable**.



## Flip a flipper

Imagine a page with "flipper" for choosing a card. To select a card, user has to make a right finger movement in a right direction.  
_How to emulate it with Selenium?_
It's possible. All those Drag'n'Drop, Actions. Press, hold, move, release. All this is **slow and unstable**.  
It can easily be broken because of minor design changes, different browser size, focus lost etc. 

#### And this a solution with JavaScript:

```java
void selectAccount(String accountId) {
  executeJavaScript(
    String.format("$('[data-account-id=\"%s\"]').attr('data-card-account', 'true')", accountId)
  );
}
```

Yes, it's not trivial. We had to dive into the flipper's code and understand what JS code it calls on flipping.  
And call similar JS code from test. Yes, you need to apply your head, but this solution is **fast and stable.** 


## Choose and option in bootstrap select

Many UI frameworks replace the standard `<select>` with custom home-made "nice"/"usable" elements, made from 
bunch of `<div>`s, `<span>`s, `<li>`s etc. with bunch of CSS classes and styles. It's always a pain for automation.

One of such UI frameworks is Bootstrap. It also has its `<select>`. We tried hard, but failed to clicks all those 
  `<div>`s and `<span>`s in the right order to select the right option. 


At the end, we implement the method: 
```java
@Test {
  selectBootstrap($(By.name("operationCode")), "11100");
}
```

with JavaScript:

```java
void selectBootstrap(WebElement select, String value) {
  executeJavaScript(
    "$(arguments[0]).val(arguments[1]).trigger('change')", 
     select, value);
}
```

**Fast and stable.** 

By the way, with the help of [`execute` method](https://selenide.org/2019/09/02/selenide-5.3.0/) you can make it even nicer:

```java
$(By.name("operationCode")).execute(selectBootstrap("11100"));
``` 

## Slider

There is a slider on a page. User can drag the slider back and forth from 0 to 100.  
How to do it in test?

```java
@Test {
  setMaxYearlyFee(100);
}
```

Even classical Drag'n'Drop doesn't work here because we just haven't a target element.  
Again, we can use Actions: press - hold - drag (by coordinates?) - release. Again, it's **slow and unstable**.

#### But we can use JavaScript:

```java
void setMaxYearlyFee(int value) {
  executeJavaScript(
    "$('#sld').data('slider').value[0] = arguments[0];" +
    "$('#sld').triggerHandler('slide');"
  );
}
```

Again, we had to dive into the slider code. But it works. It's **fast and stable**.



## But it's not real?

I know, many of you are frustrated because "it's not real, it's fake. Tests must emulate real user's behaviour.
Otherwise tests can miss some real problem."

I understand. 

But I will argue. 

> Fast and stable tests
> are much, much better than
> “realistic” (but slow and unstable) tests. 


* If 30% of your tests fail during every run,
* If you spent few hours to analyze every failed build,   
* If you manually click through your "automated" scripts to check that functionality is not broken (and it was just a flaky test),  
* If you fill an excel with failed-but-manually-checked test,  
* If there is _no trust for tests_ in your company,  

then _what the hell is the benefit of your tests_?  
Hard, only harm.

* I prefer fast and stable tests.  
* I prefer tests that can easily emulate dependencies and check "complex" scenarios that are almost impossible to reproduce in a "realistic" way.  
* I prefer to live in peace with understanding that the goal of automated testing was never to _automate everything_.   

<br/>

You might still say:
### Nevertheless, my soul is calmer when everything is "for real".

Sorry, I have to upset you. 
* You "realistic" Selenium WebDriver tests will never be _real_. They work _differently_ (compare to real users). 
WebDriver sends a http request for each your command, and even - surprise! - applies some logic on JavaScript to check visibility of elements etc.
* In some sense, actions with JavaScript are even more "realistic" that with WebDriver. It's closer to what browser actually does. 
* And even your manual testers clicking through you scenarios - are _not real_! They work _differently_ (compare to real users).

Live now with it. :)


## What's next?

That's it. It was the last post of Selenide Advent Calendar 2019. Uhhhh! 

I will be honest: I wrote it to train my hands and get used to write a lot. I hope it will help me to [update our site](https://selenide.org/selenide-site-ng/) 
 and write Selenide documentation. Maybe even book. :) 

These are the plans for next year.

Happy New Year!

<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
