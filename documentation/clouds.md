---
layout: page
title :
header : Clouds
group: navigation
cssClass: docs
header-text: >
  <h4>Documentation</h4>

  Clouds
---
{% include JB/setup %}

{% include documentation-menu.md %}

<br>

#### [&gt; Selenium Grid](#selenium-grid)
#### [&gt; TestContainers](#testcontainers)  
#### [&gt; TestMu AI (ex. LambdaTest)](#testmu-ai)
#### [&gt; BrowserStack](#browserstack)  
#### [&gt; Saucelabs](#saucelabs)  
#### [&gt; Moon](#moon)   
#### [&gt; Selenoid](#selenoid)   
#### [&gt; Other cloud providers](#other)  
{: .blogpost-menu}

<br>
<br>

The easiest, fastest and most reliable way is to launch a browser on the same machine with the test (the so-called “local” launch).
Or maybe in a Docker container on the same machine.

But people are not looking for simple ways. Sometimes they want to run the browser in the clouds.
In theory, this can give you some advantages: infinite scaling and running different versions of different browsers.
But of course, there are also difficulties and limitations. 

Selenide allows you to do this quite easily.
To run a browser remotely, you need to use setting `remote`:

```java
Configuration.remote = "https://your-cloud-provider.com/wd/hub";
```

<a name="selenium-grid"></a>
## Selenium Grid

Written in Java by the Selenium team.

### How to use:
```xml
<dependency>
  <groupId>com.codeborne</groupId>
  <artifactId>selenide-grid</artifactId>
  <version>{{site.SELENIDE_VERSION}}</version>
</dependency>
```

### Pros
* Works without docker. Supports all browsers (that have webdriver) of any versions.
* Scalable: you can run multiple nodes on different OSs with browsers of different versions.
* You can run it on your own servers and locally.

### Cons
* Does not support operations with clipboard


<a name="testcontainers"></a>
## TestContainers

Allows running a browser in a docker container with just one annotation. 

A working example: [selenide-examples/testcontainers](https://github.com/selenide-examples/testcontainers/).

Pros:
1. Allows running different browser versions
2. Can save video from test running (and many other features of TestContainers)
3. Most Selenide features still work (screenshots, proxy, CDP etc.)

Cons:
1. Some Selenide features may not work (e.g. clipboard)
2. Only those browsers are supported that are capable of running in Docker (Internet Explorer is definitely not, not sure about Safari)

<br>

<a name="testmu-ai"></a>
## TestMu AI (ex. LambdaTest)

A working example: [selenide-examples/selenide-lambdatest](https://github.com/selenide-examples/selenide-lambdatest).  
Website: [testmu.ai](https://www.testmu.ai/blog/selenium-testing-with-selenide-using-intellij-maven/?utm_source=selenide&utm_medium=partnered).

This is a working example of Selenide tests that run the browser on TestMu AI (ex. LambdaTest) servers.
As you can see, the settings there are minimal:

```java
  Configuration.remote = "https://hub.lambdatest.com/wd/hub";
  Configuration.browserCapabilities.setCapability("LT:Options", Map.of(
    "user", "unclebob",
    "accessKey", "0123456789001234567890"
));
```

Pros:
1. Allows running different browser versions

Cons:
1. Some Selenide features may not work (e.g. clipboard, proxy, download to folder)

<br> 

<a name="browserstack"></a>
## BrowserStack

A working example: [selenide-examples/selenide-browserstack](https://github.com/selenide-examples/selenide-browserstack).  
Website: [BrowserStack.com](https://www.browserstack.com/?utm_source=selenide&utm_medium=partnered)

This is a working example of Selenide tests that run the browser on BrowserStack servers.
As you can see, the settings there are minimal:

```java
  Configuration.remote = "https://hub-cloud.browserstack.com/wd/hub";
  Configuration.browserCapabilities.setCapability("bstack:options", Map.of(
    "userName", "unclebob",
    "accessKey", "0123456789001234567890"
  ));
```

Pros:
1. Allows running different browser versions

Cons:
1. Some Selenide features may not work (e.g. clipboard, proxy, download to folder)

<br> 

<a name="saucelabs"></a>
## Saucelabs

Saucelabs company also allows running browsers and mobile apps on their servers. 

[An example](https://github.com/markwinspear/selenide-test-2015) (this is quite old, but we hope to update it soon).

Pros:
1. Allows running different browser versions

Cons:
1. Some Selenide features may not work (e.g. clipboard, proxy, download to folder)

<br>

<a name="moon"></a>
## Moon

Like Selenium Grid, but in docker. And it's written in Go, so it's fast and uses little memory. 

### How to use:
```xml
<dependency>
  <groupId>com.codeborne</groupId>
  <artifactId>selenide-moon</artifactId>
  <version>{{site.SELENIDE_VERSION}}</version>
</dependency>
```

* Sources: [on github](https://github.com/selenide/selenide/tree/main/modules/moon).
* Working example: [on github](https://github.com/selenide/selenide/tree/main/modules/moon/src/test/java/it/moon)

### Pros:
1. Directly supported by Selenide 
2. Supports some Selenide features (that may not work in other clouds): clipboard, downloading files.
3. Allows running different browser versions
4. Can save video from running tests

### Cons:
1. Only those browsers are supported that are capable of running in Docker (Internet Explorer is definitely not, not sure about Safari)

<br>

<a name="selenoid"></a>
## Selenoid

Like Selenium Grid, but in docker. And it's written in Go, so it's fast and uses little memory. 

### How to use:
```xml
<dependency>
  <groupId>com.codeborne</groupId>
  <artifactId>selenide-selenoid</artifactId>
  <version>{{site.SELENIDE_VERSION}}</version>
</dependency>
```

* Sources: [on github](https://github.com/selenide/selenide/tree/main/modules/selenoid).
* Working example: [on github](https://github.com/selenide/selenide/tree/main/modules/selenoid/src/test/java/it/selenoid)


### Pros:
1. Directly supported by Selenide
2. Supports some Selenide features (that may not work in other clouds): clipboard, downloading files.
3. Allows running different browser versions
4. Can save video from running tests

### Cons:
1. Only those browsers are supported that are capable of running in Docker (Internet Explorer is definitely not, not sure about Safari)

<br>

<a name="other"></a>
## Other cloud providers

In theory, other cloud providers should integrate just as easily. 

What other providers have you tried? Pros, cons, pitfalls?
Tell us, share the code. 

And the most important, _was it worth it_?
Tell us, what kind of problems does remote browser run solve, why was it worth sacrificing speed, convenience and some features?

<br/>
<br/>
