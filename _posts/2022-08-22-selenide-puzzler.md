---
layout: post
title: "Selenide puzzler"
description: ""
category:
header-text: "Logical AND or OR?"
tags: []
---
{% include JB/setup %}

<br>
# Good night!

Do you love puzzlers?
Did you miss puzzlers?

We recently published a new [puzzler in Twitter](https://twitter.com/selenide/status/1560192824536088580):

> Do these lines work equally? Or is there some difference?

```java
1. $(".btn").shouldBe(visible, enabled);
2. $(".btn").shouldBe(visible).shouldBe(enabled);
```

### Answer options

You gave us many answers:
* both lines work equally (the most popular answer)
* the first case is "logical or", and the second is "logical and"
* the second runs %timeout% seconds longer
* the first runs with one timeout, the second run with two timeouts
* the first fails if one of conditions is false, the second fails if the element is not visible, but is enabled.

### Correct answer

In most cases both variants work equally. 

Both variants is "logical AND". In both cases Selenide will check that the element matches both conditions.

|               | **enabled** | **disabled** |
| **visible**   | ok          | nok          |
| **invisible** | nok         | nok          |

<br>

But there is a nuance.

### The nuance


The difference will appear if the element meets the conditions not immediately, but after some time.
Moreover, the first condition should be met in less than 4 seconds, and the second - in more than 4 seconds.
(Say, it gets visible after 3.5 seconds, and enabled - after more 3.5 seconds).

> The thing is that the method `shouldHave` has the timeout (by default 4 seconds), while conditions
(`visible`, `enabled`, `cssClass`, `text`) don't have any timeouts - they can just check "matches" or "doesn't match". 

### Example

For example, let's open [Traffic light](https://selenide.org/traffic-light.html).
The light gets green after 3.5 seconds, and after next 3.5 seconds a text "Go!" appears on it.

The first variant checks if the light gets both color and text during 4 seconds:

```java
  $("#light").shouldHave(cssClass("green"), text("GO!")); // timeout 4 seconds
```

This variant fails because the light doesn't get both color and text in 4 seconds (it gets the text "Go" after 7 seconds).

The second variant will not fail:
```java
$("#light")
  .shouldHave(cssClass("green")) // timeout 4 seconds
  .shouldHave(text("GO!")); // another timeout 4 seconds
```

The first `shouldHave` waits until the element gets green (and it gets during 4 seconds).
Then the second `shouldHave` gets started which waits until the element gets text "Go!" (and it gets it during next 4 seconds).

Apparently, the closest answer was "the first runs with one timeout, the second run with two timeouts". 

### Your puzzlers? 

Do you have your own puzzlers?
Share with us! Send us! Send'em all! Let's guess them together!


[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
