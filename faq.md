---
layout: page
title : FAQ
header : Frequently Asked Questions
group: navigation
cssClass: faq
header-text: Frequently Asked Questions
---
{% include JB/setup %}

## Motivation

> Why Selenium webdriver is not enough?

> Why yet another Selenium wrapper?

Briefly: shorter code, easier to read, no need to re-invent the wheels.

And lots of features for testing.  
And automated screenshots and reports.  
And video recording.  
And tests for mobile apps.  
And much, much more...

Find more detailed answer [here](/documentation/selenide-vs-selenium.html)

## Page Objects
> Can I use Page Objects with Selenide?

Yes! You can use Page Objects with Selenide.

Moreover, your page objects get **concise and readable** with Selenide. See [more details here](/documentation/page-objects.html).


## Settings
> Where can I find list of all Selenide settings?

A detailed description of all Selenide settings and default values can be found in [javadoc](https://selenide.org/javadoc/current//com/codeborne/selenide/Configuration.html).

> How can I change Selenide settings?

Selenide has very reasonable default settings. 
They should be convenient for most "normal" projects. 

If you still want to run tests with another settings, you can do it either using System property:

```
-Dselenide.timeout=6000
```

or programmatically, right from your tests:

```java
public void setUp() {
  Configuration.timeout = 6000;
}
```

Also, you can create file "selenide.properties" in classpath 
(in a typical project, it means create file `src/test/resources/selenide.properties`):

```java
> cat src/test/resources/selenide.properties
selenide.timeout=6000
selenide.browser=edge
selenide.remote=https://hub.lambdatest.com/wd/hub
selenide.textCheck=FULL_TEXT
```

About browser settings - you don't need to always specify them globally.
You can also specify them every time when opening a browser:
```java
Config config = new SelenideConfig().browser("firefox").browserSize("800x600");
open("/one", config);
```

[Use carefully!](/2024/09/15/selenide-7.5.0/#new-configuration-for-every-browser)



## Browsers
>Can I run Selenide tests with Internet Explorer? Headless browser?

Yes.
Selenide can run tests with any browsers that has webdriver binding. The most popular browsers are supported from the box
(chrome, firefox, edge, ie, safari, opera).

Some less popular are also supported with a little configuration (e.g. htmlunit).
See [Wiki](https://github.com/selenide/selenide/wiki/How-Selenide-creates-WebDriver).


Other browsers can be also used by passing webdriver class name (or factory class name).

<br/>
E.g. to run tests with Firefox browser:
```-Dselenide.browser=firefox```

<br/>

>How can I tell Selenide use browser with my custom profile?

You can also provide Selenide an instance of webdriver that you configured according to your needs.
Go to [Wiki](https://github.com/selenide/selenide/wiki/How-Selenide-creates-WebDriver) for details.

<br/>

>Can I use Selenide with Selenium Grid?

Yes, Selenide supports Selenium Grid. Just add property when running tests:
> -Dselenide.remote=https://your.grid.com:5678/wd/hub

Most of the functions will work out-of-the-box.  
But for some features (e.g. downloading files) you will need to add dependency `com.codeborne:selenide-grid`.

See [selenide-grid plugin](/2024/02/27/selenide-7.2.0/#download-files-to-folder-in-selenium-grid)


<br/>

>Can I use Selenide with Selenoid?

Yes, Selenide supports Selenoid. Just add property when running tests:
> -Dselenide.remote=https://your.selenoid.com:5678/wd/hub

Most of the functions will work out-of-the-box.  
But for some features (e.g. downloading files) you will need to add dependency `com.codeborne:selenide-selenoid`.

See [selenide-selenoid plugin](https://github.com/selenide/selenide/tree/main/modules/selenoid).


>Can I use Selenide with Selenoid/Moon/BrowserStack/LambdaTest/TestMu AI/TestContainers or other cloud providers?

Yes. See [documentation](/documentation/clouds.html)


<br/>

>Can I use Selenide for testing mobile applications?

Yes, Selenide supports testing of mobile applications using Appium.

This is what you need to do:
1. Add to your dependency Selenide plugin [selenide-appium](https://github.com/selenide/selenide/tree/main/modules/appium).
2. Find working examples [on github](https://github.com/selenide-examples/selenide-appium)
3. Watch a presentation about [using Selenide for mobile](https://www.youtube.com/watch?v=Y04rU7qV7Vg)


## Build scripts

>Can I run Selenide tests on CI (continuous integration) server?

Yes.
Please look at [Wiki page](https://github.com/selenide/selenide/wiki/Build-script/) for examples of build script
using Maven, Gradle or Ant.

## Screenshots

> Can I take screenshot?

Yes. See [documentation](/documentation.html) -> [Screenshots](/documentation/screenshots.html)

> Can I tell Selenide to put screenshots to a specific folder?

Yes. See [documentation](/documentation.html) -> [Screenshots](/documentation/screenshots.html)

## Browser windows / tabs

> How can I switch between browser windows/tabs?

You can use Selenium WebDriver API for switching between browser windows.

  * `getWebDriver().getWindowHandles()` - returns set of all browser windows/tabs
  * `getWebDriver().getWindowHandle()` - returns unique identifier of active window/tab

## Source code of Selenide

> Can I access source code of Selenide?

Sure. Source code of Selenide is published [at github](https://github.com/selenide/selenide/).

> Can I modify Selenide?

Sure! It's open-source. 
You can either create
* [Pull Request](https://github.com/selenide/selenide/pulls) or 
* [Feature Request](https://github.com/selenide/selenide/issues).

See [contributing guide](https://github.com/selenide/selenide/blob/main/CONTRIBUTING.md).

## License

> How much does Selenide cost?

> Does Selenide license allow me to share source code of tests with my customer?

Selenide - __free__ __open-source__ product distributed with [MIT license](https://github.com/selenide/selenide/blob/master/LICENSE).
Shortly said, it means that you can do anything with it.

> Wouldn't you make Selenide paid at some moment?

No. For sure. Selenide will always be free. 

* Firstly, because we believe in Open Source. 
* Secondly, because we don't believe we can earn a lot of money this way. :)

## Nice to read

- Set-up environment with gradle, junit5, allure and selenide -- read a [post](https://medium.com/@rosolko/simple-allure-2-configuration-for-gradle-8cd3810658dd) on medium, grab from [github](https://github.com/rosolko/allure-gradle-configuration)
- Small step do dramatically improve your tests speed -- read a [post](https://medium.com/@rosolko/boost-you-autotests-with-fast-authorization-b3eee52ecc19) on medium
- Another way to improve tests speed -- read a [post](https://medium.com/@rosolko/fast-authorization-level-local-storage-6c84e9b3cef1) on medium
