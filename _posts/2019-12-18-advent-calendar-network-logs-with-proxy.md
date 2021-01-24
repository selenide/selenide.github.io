---
layout: post
title: "How to get network data with proxy"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 18"
tags: []
---
{% include JB/setup %}

Good night!

In two previous posts of our Selenide Advent Calendar, we tried to find a way to read requests/responses between browser and server.     
They both were not ideal because they cannot read BODY of requests and responses. 

Finally, we try a third way - using a Selenide built-in proxy server.

### Before test

As you know, Selenide already has built-in proxy server. You only need to enable it: 

```java
Configuration.proxyEnabled = true;
```

Now you need to say the proxy to start tracking requests:

```java
  BrowserMobProxy bmp = WebDriverRunner.getSelenideProxy().getProxy();
    
  // remember body of requests (body is not stored by default because it can be large)
  bmp.setHarCaptureTypes(CaptureType.getAllContentCaptureTypes());

  // remember both requests and responses
  bmp.enableHarCaptureTypes(CaptureType.REQUEST_CONTENT, CaptureType.RESPONSE_CONTENT);

  // start recording!
  bmp.newHar("pofig");
```

### After test

Now you need to get a HAR and analyze its entries: 

```java
    List<HarEntry> requests = bmp.getHar().getLog().getEntries();
``` 

HAR (HTTP Archive) is like an "archive" with all network requests recorded during the test run.  

Every entry in it is a network request.  
It has everything needed inside: URL, request and response, their http status and body.  
Everything that we dreamed about.  

<img src="{{BASE_PATH}}/images/2019/12/har.entries.png" alt="HAR entries"/>

### Pros:

* It has all data you needed
* It's easy to analyze it programmatically 
* Works in all browsers

### Cons:

There is only one possible problem. When you run tests and browsers on different machines, and the "tests" machine 
is not accessible from the "browsers" machine, it's just technically impossible to use proxy server.  
Though I never understood why people make things that complex. 

People, just run tests and browsers on the same machine. Everything will get MUCH SIMPLER!    
If you need to parallelize - just parallelize TESTS.  
If you need a cluster (grid) - just run TESTS on different cluster nodes (and they will run their browsers locally).  
There is no reasons to make it more complex.


## What's now?

Now we can read network data during tests run.  
But I hope you don't really use it often. Usually it should not be needed. Maybe in very rare cases.     
Usually it should be enough to just read application logs to understand what requests were sent to server.

Keep it simple.  

<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org



