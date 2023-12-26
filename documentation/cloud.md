---
layout: page
title :
header : Cloud
group: navigation
cssClass: docs
header-text: >
  <h4>Documentation</h4>

  Cloud
---
{% include JB/setup %}

{% include documentation-menu.md %}

<br>

#### [&gt; TestContainers](#testcontainers)  
#### [&gt; BrowserStack](#browserstack)  
#### [&gt; Saucelabs](#saucelabs)  
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

<a name="browserstack"></a>
## BrowserStack

A working example: [selenide-examples/selenide-browserstack](https://github.com/selenide-examples/selenide-browserstack).

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

<a name="selenoid"></a>
## Selenoid

Like Selenium Grid, but in docker. And it's written in Go, so it's fast and uses little memory. 

A working example [on GitHub](https://github.com/selenide/selenide/tree/main/modules/selenoid/src/test/java/it/selenoid)

Pros:
1. Directly supported by Selenide 

    1.1. Is easily pluggable as a Selenide extension 'com.codeborne:selenide-selenoid:{{site.SELENIDE_VERSION}}'  
    1.2. Supports some Selenide features (that may not work in other clouds): clipboard, downloading files.  

2. Allows running different browser versions
3. Can save video from running tests

Cons:
1. Only those browsers are supported that are capable of running in Docker (Internet Explorer is definitely not, not sure about Safari)

<br>

<a name="other"></a>
## Other cloud providers

In theory, other cloud providers should integrate just as easily. 

What other providers have you tried? Pros, cons, pitfalls?
Tell us, share the code. 

<br/>
<br/>
