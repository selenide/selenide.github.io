---
layout: post
title: "Actions"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 12"
tags: []
---
{% include JB/setup %}

Hi! 

In today’s advent calendar article we will check how to perform special operations in Selenide. 

Sometimes in our tests we encounter weird problems. 
It is 100% sure that all of us have experienced, or will experience some unusual problem that will make our work blocked. 
It happens quite often that for example we cannot click some element on the page, and standard selenium/selenide command like: 

```java
  element.click();
```

does not work. There can be many different reasons that will make our click operation ineffective but we cannot give up 
just like that, and we have to find some solution. In this case, in Selenium we had `Actions` class that helped us performing click operation in a bit different way:

```java
  WebElement element = <Some selector>;
  Actions actions = new Actions(driver);
  actions.moveToElement(element);
  actions.click();
  actions.build().perform();
```
 
This way we were able to click the element and solve some of our problems occurring in tests.  

#### But how can we do it in Selenide?  

As it turns out, it is easier and simpler than it was in Selenium.  
Selenide solves many problems that were quite common in Selenium, but if we need to perform some things in a bit 
different way, actions are still available in Selenide. Here we can check how it goes:

```java
  SelenideElement element = $(<some selector>);
  actions().moveToElement(element).click(element).perform();
```
 
As we can see, `actions` is just a method available when we have:
```java
  import static com.codeborne.selenide.Selenide.*;
```

imported to our project. Notice that no driver is needed to use `actions()` method! 
 
##### Crazy drag and drop

If you have read the documentation, you probably already know that there are two types of drag and drop operations available in Selenide by default:

1. `dragAndDropTo​(java.lang.String targetCssSelector);`
2. `dragAndDropTo​(org.openqa.selenium.WebElement target);` 

First method will let us drag and drop element to CSS selector defining target element.  
Second method will just let us drag and drop some element to another one.
 
But what if we want to perform drag and drop action and we have no target element or css selector available?  
For example, we have just an empty page and we want to put there some objects in many different places.  
In this case, actions method will help us again. In Selenium we would have to code something like this:

```java
  WebElement element = driver.findElement(By.some);
  Actions actions = new Actions(driver);
  actions.dragAndDropBy(element, xOffset, yOffset).perform();
```	

Where `xOffset` is a horizontal move offset and `yOffset` is a vertical move offset.

In Selenide it should look like this:

```java
	SelenideElement element = <Some selector>;
	actions().dragAndDropBy(element, xOffset, yOffset).perform();
```

This way we can drag and drop some object to the desired location without using additional target identifiers. 

## What's next
 
Of course, these are just two examples of using special methods in Selenide and user can experiment with many more options. 

Enjoy actions() !

Maciej Grymuza (figrym@gmail.com)

