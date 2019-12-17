---
layout: post
title: "How to get network data with JavaScript"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 17"
tags: []
---
{% include JB/setup %}

Good night!

In the yesterday post we tried to get browser logs with "goog:loggingPrefs" capability.  
Now we will try to get browser network data with JavaScript.

It's simple. We just need to call this JavaScript in the end of test:

```java
String js = 
   "var performance = window.performance || window.mozPerformance" +
                   " || window.msPerformance || window.webkitPerformance || {};" +
   " return performance.getEntries() || {};";
String netData = executeJavaScript(js).toString();
logger.info("Network traffic: {}", netData);
```

The result looks like this: 

```json
Network traffic: [
  {name=https://selenide.org/quick-start.html, connectEnd=0, connectStart=0, decodedBodySize=32582, domComplete=724, domContentLoadedEventEnd=119, domContentLoadedEventStart=115, domInteractive=104, domainLookupEnd=0, domainLookupStart=0, duration=724, encodedBodySize=32582, entryType=navigation, fetchStart=0, initiatorType=navigation, loadEventEnd=724, loadEventStart=724, nextHopProtocol=http/1.1, redirectCount=0, redirectEnd=0, redirectStart=0, requestStart=0, responseEnd=0, responseStart=0, secureConnectionStart=0, serverTiming=[], startTime=0, transferSize=0, type=navigate, unloadEventEnd=10, unloadEventStart=9, workerStart=0},
  {name=https://selenide.org/assets/themes/ingmar/css/styles.css?001, connectEnd=12, connectStart=12, decodedBodySize=8177, domainLookupEnd=12, domainLookupStart=12, duration=29, encodedBodySize=8177, entryType=resource, fetchStart=12, initiatorType=link, nextHopProtocol=http/1.1, redirectEnd=0, redirectStart=0, requestStart=12, responseEnd=41, responseStart=21, secureConnectionStart=0, serverTiming=[], startTime=12, transferSize=0, workerStart=0},
  {name=https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js, connectEnd=13, connectStart=13, decodedBodySize=84245, domainLookupEnd=13, domainLookupStart=13, duration=28, encodedBodySize=84245, entryType=resource, fetchStart=13, initiatorType=script, nextHopProtocol=http/1.1, redirectEnd=0, redirectStart=0, requestStart=13, responseEnd=41, responseStart=21, secureConnectionStart=0, serverTiming=[], startTime=13, transferSize=0, workerStart=0}
]
```

### Pros:

* You don't need to setup the browser. It works out of the box. 
* It works in all browsers (I guess?)

### Cons:

* We still don't see request body here.
* It's not a valid JSON. We cannot parse it with a standard parser. Would need to create some custom parser.  


But this option is quite ok to look at and understand what happens.  


## What's next?

Our last hope to get request bodies is built-in proxy server. We will look at it next time.  

<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org


