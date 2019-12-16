---
layout: post
title: "How to get browser logs"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 16"
tags: []
---
{% include JB/setup %}

Good evening!

We continue our Selenide Advent Calendar.  
Today we will try to look into browser "developer tools".  
It may be useful if you want to know what errors happened during test run, or what requests your AUT sent.   

Chromedriver suggests the following receipt. 


### 1. Add a couple of lines before opening a browser:

```java
LoggingPreferences logPrefs = new LoggingPreferences();
logPrefs.enable(LogType.BROWSER, Level.ALL);
logPrefs.enable(LogType.PERFORMANCE, Level.ALL);
capabilities.setCapability("goog:loggingPrefs", logPrefs);
```

This capability was named "loggingPrefs" until some version of Chrome, and then was renamed to "goog:loggingPrefs".  
Not sure about other browsers.  

Besides `BROWSER` and `PERFORMANCE` there are other types too, but I didn't understand them. 


### 2. Fetch the logs in the end of test:

```java
Logs logs = getWebDriver().manage().logs();
printLog(logs.get(LogType.BROWSER));

void printLog(LogEntries entries) {
    logger.info("{} log entries found", entries.getAll().size());
    for (LogEntry entry : entries) {
      logger.info("{} {} {}",
        new Date(entry.getTimestamp()), entry.getLevel(), entry.getMessage()
      );
    }
  }
```

### 3. This is how BROWSER logs look like:

```java
BROWSER logs:

Mon Dec 16 19:29:42 EET 2019 SEVERE http://localhost:9126/page/image/payment-promo-capaign-ozon.png - Failed to load resource: the server responded with a status of 404 (Not Found)
Mon Dec 16 19:49:14 EET 2019 INFO console-api 19:16 "start loading loans"
Mon Dec 16 19:49:14 EET 2019 INFO console-api 21:18 "loaded loans"
```

Here you can see all logs usually seen at "Developer Tools" -> "Console" tab. Including `console.log` messages and JavaScript errors.  


### 4. And this is how PERFORMANCE logs look like:

```json
PERFORMANCE logs:

{"message":{"method":"Network.loadingFinished","params":{"encodedDataLength":0,"requestId":"2C9E49BC49DCD3CA6EA9644255E34DE5","shouldReportCorbBlocking":false,"timestamp":141439.076528}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
{"message":{"method":"Page.loadEventFired","params":{"timestamp":141439.234207}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
{"message":{"method":"Page.frameStoppedLoading","params":{"frameId":"FF1A4E4EAAD7143749CD3740DF9BB95F"}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
{"message":{"method":"Page.domContentEventFired","params":{"timestamp":141439.234834}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
{"message":{"method":"Page.frameResized","params":{}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
...
{"message":{"method":"Network.dataReceived","params":{"dataLength":0,"encodedDataLength":327,"requestId":"58583.71","timestamp":141474.021635}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
{"message":{"method":"Network.loadingFinished","params":{"encodedDataLength":586,"requestId":"58583.71","shouldReportCorbBlocking":false,"timestamp":141473.994219}},"webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"}
```

### Pros

Every record is a valid JSON. You can parse and analyze right in your test.

This is how the first record looks formatted:

```json
{ 
   "message":{ 
      "method":"Network.loadingFinished",
      "params":{ 
         "encodedDataLength":0,
         "requestId":"2C9E49BC49DCD3CA6EA9644255E34DE5",
         "shouldReportCorbBlocking":false,
         "timestamp":141439.076528
      }
   },
   "webview":"FF1A4E4EAAD7143749CD3740DF9BB95F"
}
``` 

### Cons

* It's hard to understand those logs. Some additional analyzers might be needed. 
* We don't see request body here.  



## What's next?

Next time we will try other ways to get browser logs - including http statuses and request bodies.

<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org



