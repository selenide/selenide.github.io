---
layout: post
title: "Code simplicity"
description: ""
category:
header-text: "is a goodness"
tags: []
---
{% include JB/setup %}

Let's talk about simplicity of code
Probably all of you are agree that simple code is a good code.
The problem is that we all understand "simplicity" differently.

Let me show an example from one of site comments. So we can compare two variants and decide which one is simple.  

### A goal
There is some "Gmail"-like list with checkboxes and titles. We need a page object allowing to find by title and click one or more checkboxes.

### HTML structure
is not really important, but it looks like this:

```html
<div class="box">
  <div class="boxCheckbox">
    <input type="checkbox">...</input>  
  </div>
  <div class="boxLabel">
    Here is checkbox #1  
  </div>
</div>
<div class="box">
  ...
</div>
...
```

here we have several `<div class="box">`, each contains a pair `<div class="boxCheckbox">` + `<div class="boxLabel">`.

### The complex code

The following is a **typical** code that I saw so many-many times.
I often think that this **is** nowadays automation.   

```java
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import java.util.ArrayList;
import java.util.List;

public class SeleniumPageObject {

  // Search for element index in the list by title
  public static List<Integer> findListIndexesByTitle(List<WebElement> elementList, String SearchText) {
    List<Integer> ints = new ArrayList<>();
    for (int i = 0; i < elementList.size(); i++) {
      if (elementList.get(i).getText().contains(SearchText)) {
        ints.add(i);
      }
    }
    return ints;
  }

  // Buttons in the boxes
  @FindBy(xpath = "//div[@class='boxCheckbox']")
  private List<WebElement> selectCheckBoxesInBoxes;

  // Titles for boxes
  @FindBy(xpath = "//div[@class='boxLabel']")
  private List<WebElement> listOfTitlesInBoxes;

  // Select Box by title
  public void selectBoxByTitle(String searchTitle) {
    int index = findListIndexesByTitle(listOfTitlesInBoxes, searchTitle).get(0);
    selectBoxByIndex(index);
  }

  // Select Box by index
  private void selectBoxByIndex(int elPosition) {
    selectCheckBoxesInBoxes.get(elPosition).click();
  }

  // Select All Boxes by title
  public void selectAllBoxesByTitle(String searchTitle) {
    List<Integer> ints = findListIndexesByTitle(listOfTitlesInBoxes, searchTitle);
    for (int i = 0; i < ints.size(); i++) {
      selectBoxByIndex(ints.get(i));
    }
  }
}
```

You probably know that [comments in code are not needed](https://asolntsev.github.io/en/2010/05/02/javadoc/), 
and why [`@FindBy` doesn't make things better](https://asolntsev.github.io/en/2016/07/09/true-page-object/) etc.
 
Just compare these two code snippets.    

### The simple code

I managed to convert the code about to Selenide:

```java
import com.codeborne.selenide.SelenideElement;

import static com.codeborne.selenide.Condition.text;
import static com.codeborne.selenide.Selenide.$$;

public class SelenidePageObject {
  public void selectBoxByTitle(String title) {
    selectBox($$(".boxLabel").findBy(text(title)));
  }

  public void selectAllBoxesByTitle(String searchTitle) {
    $$(".boxLabel").filterBy(text(searchTitle)).forEach(this::selectBox);
  }

  private void selectBox(SelenideElement boxLabel) {
    boxLabel.closest(".box").find(".boxCheckbox").click();
  }
}
```

Don't you think that's SIMPLE?

The latter variant is not ideal. But it's much shorter and simpler. It's easy to maintain. 
It's easy to read. It's easy to understand. It's easy to modify. At the end, it's easy to drop it off and write from the scratch.  

P.S. Have you noticed the trick? I said that I converted the code to Selenide, but the profit came mostly from 
simplifying selectors, removing unneeded code, using lambdas (read: contemporary language tools). 
You all can do it. 

Appreciate the simplicity, my friends!

<br>

[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
