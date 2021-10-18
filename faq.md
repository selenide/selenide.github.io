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

See answer [here](/documentation/selenide-vs-selenium.html)

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

## Browsers
>Can I run Selenide tests with Internet Explorer? Headless browser?

Yes.
Selenide can run tests with any browsers that has webdriver binding. The most popular browsers are supported from the box
(chrome, firefox, edge, ie, safari, opera).
Some less popular are also supported with a little configuration (phantomjs, htmlunit).
See [Wiki](https://github.com/selenide/selenide/wiki/How-Selenide-creates-WebDriver).


Other browsers can be also used by passing webdriver class name.

<br/>
E.g. to run tests with Firefox browser:
```-Dselenide.browser=firefox```

<br/>

>How can I tell Selenide use browser with my custom profile?

You can also provide Selenide an instance of webdriver that you configured according to your needs.
Go to [Wiki](https://github.com/selenide/selenide/wiki/How-Selenide-creates-WebDriver) for details.

<br/>

>Can I use Selenide with Selenium Grid?

Yes, Selenide supports Selenium Grid. Just add property `-Dselenide.remote=http://localhost:4444/wd/hub` when running tests.

<br/>

>Can I use Selenide with Selenoid?

Yes, Selenide supports Selenoid. Just add property `-Dselenide.remote=http://localhost:4444/wd/hub` when running tests.  
We also recommend using Selenide plugin [selenide-selenoid](https://github.com/selenide/selenide-selenoid).

<br/>

>Can I use Selenide for testing mobile applications?

Yes, Selenide supports testing of mobile applications using Appium. 
1. We also recommend using Selenide plugin [selenide-appium](https://github.com/selenide/selenide-appium).
2. You can find working examples [on github](https://github.com/selenide-examples/selenide-appium)
3. You can watch a presentation about [using Selenide for mobile](https://www.youtube.com/watch?v=Y04rU7qV7Vg)


## Build scripts

>Can I run Selenide tests on CI (continuous integration) server?

Yes.
Please look at [Wiki page](https://github.com/selenide/selenide/wiki/Build-script/) for examples of build script.

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

Sure! It's open-source. You can either create Pull Request or [Feature Request](https://github.com/selenide/selenide/issues).

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
