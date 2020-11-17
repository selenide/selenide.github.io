---
layout: post
title: "Why proxy does not work in Selenoid?"
description: ""
category:
header-text: "We're addicted to dependencies"
tags: []
---
{% include JB/setup %}

Good night!
 
Today we will finally reveal the secret of why proxy does not often work in Selenoid. 

### The goal: download a file
* We run tests which open browsers in Selenoid containers (usually with Selenide, but it's not important in this case).   
* We want to download a file during the test.  
* Default method `$.download()` doesn't work (for example, because the download starts by submitting a form - there is no direct link to the file).
* That's why we want to [download file via proxy](https://selenide.org/2019/12/10/advent-calendar-download-files/).

### Our plan
1. Create a project
2. Add BrowserUpProxy dependency as shown in Selenide documentation:
```kotlin
dependencies {
  testRuntimeOnly("com.browserup:browserup-proxy-core:2.1.1")
}
``` 
3. Copy-paste a typical boilerplate to run browsers in Selenoid:
```java
Configuration.proxyHost = "192.168.0.10";
Configuration.remote = "http://localhost:4444/wd/hub";
DesiredCapabilities capabilities = new DesiredCapabilities();
capabilities.setBrowserName("chrome");
capabilities.setVersion("85.0");
capabilities.setCapability("enableVNC", true);
capabilities.setCapability("enableVideo", true);
capabilities.setCapability("enableLog", true);
Configuration.browserCapabilities = capabilities;
Configuration.fileDownload = FileDownloadMode.PROXY;
Configuration.proxyEnabled = true;
```

4. And write a test, something like this:
```java
open("https://the-internet.herokuapp.com/download");
File file = $(byText("some-file.txt")).download();
assertThat(file.getName()).isEqualTo("some-file.txt");
```

### The problem

And we get an error when opening a browser:
```java
org.openqa.selenium.WebDriverException: unknown error: net::ERR_TUNNEL_CONNECTION_FAILED
    ...
	at com.codeborne.selenide.Selenide.open(Selenide.java:49)
	at org.selenide.selenoid.FileDownloadTest.download(FileDownloadTest.java:45)
```
<br>

### AAA, panic mode!

At this point, most people panic, go through a bunch of browser options and Selenide settings
and in the end write to one of the QA chats. 

But all you had to do was read the log carefully.  

The problem is clearly visible in the log:

```java
[LittleProxy-0-ProxyToServerWorker-1] ERROR org.littleshoot.proxy.impl.ProxyToServerConnection
                        - (HANDSHAKING) [id: 0xc05a41d5, L:/10.10.10.145:56103
                        - R:the-internet.herokuapp.com/52.1.16.137:443]
                        : Caught an exception on ProxyToServerConnection
java.lang.NoSuchMethodError: 'int io.netty.buffer.ByteBuf.maxFastWritableBytes()'
	at io.netty.handler.codec.ByteToMessageDecoder$1.cumulate(ByteToMessageDecoder.java:86)
``` 

### Tune the dependencies

Exception `NoSuchMethodError` clearly says that we have a problem with dependencies: 
apparently, there are two JAR's with incompatible versions in classpath. 

The humanity invented a vaccine against this a long time ago. 
I wonder why so many people still don't know it.

Let's run command

* `gradle dependencies`, or
* `mvn dependency:tree` 

And we clearly see which JAR's have which versions. Let's look for something similar to "netty".  

```
\--- com.browserup:browserup-proxy-core:2.1.1
     +--- io.netty:netty-codec:4.1.44.Final
     +--- xyz.rogfam:littleproxy:2.0.0-beta-5
     |    +--- io.netty:netty-all:4.1.34.Final
```

We have two jars with different versions: `netty-codec:4.1.44.Final` and `netty-all:4.1.34.Final`.  

### Treating dependencies

There are many ways to fix the problem. 
Probably the easiest one is to declare Netty versions explicitly in `build.gradle` or `pom.xml`:

```kotlin
testRuntimeOnly("io.netty:netty-all:4.1.54.Final")
testRuntimeOnly("io.netty:netty-codec:4.1.54.Final")
```

(actually it's enough to declare just one of them. *Homework for you: which one and why?*)

Now command `gradle dependencies` shows that Netty versions are matching:
 
```
\--- com.browserup:browserup-proxy-core:2.1.1
     +--- io.netty:netty-codec:4.1.44.Final -> 4.1.54.Final
     +--- xyz.rogfam:littleproxy:2.0.0-beta-5
     |    +--- io.netty:netty-all:4.1.34.Final -> 4.1.54.Final
```

The test runs, proxy works, file is being downloaded. Everyone is happy.  

### Moral

Pay attention to the logs, our smaller brothers!

<br/>
 
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
