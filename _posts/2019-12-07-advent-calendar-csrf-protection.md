---
layout: post
title: "How to test CSRF protection"
description: ""
category:
header-text: "Selenide Advent Calendar<br/>Day 7"
tags: []
---
{% include JB/setup %}

Hi all!

Today is 7th day of our Selenide Advent Calendar.    
Today we will talk about testing security.   

# What is CSRF?

[CSRF](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)) is one of the most popular security attacks (Cross-Site Request Forgery).   

To protect itself from CSRF attack, a web-application should add a special parameter to (almost) every POST request.
Typically it's called `authenticityToken` (though the name may vary). 

A typical mistake is when web-application either doesn't send `authenticityToken` to server with some POST request or
doesn't check it on server side. 

### How to check the protection?

I assume you have some automated tests covering the most critical functionality of your web application.  
We will kill two birds with one stone: during run of your tests, we will intercept every POST request and send exactly 
the same request, but with modified `authenticityToken`. And verify that the server returned an error. Usually it should be "403 Forbidden". 


### Sounds hard. How to program it?

Now so hard.  
As you know, Selenide can run its own embedded proxy server. Initially it was created for downloading files, but
it also allows to add your own listeners which can intercept all requests between browser and server.
We are going to use it.  

<br/> 
<br/> 

#### Step 1. Enable Selenide proxy 

```java
Configuration.proxyEnabled = true;
```

(you need to do it BEFORE opening a browser)

<br/> 
<br/> 

#### Step 2. Add listener for the proxy

```java
abstract class BaseTest {
  private AuthenticityTokenChecker authenticityTokenChecker = new AuthenticityTokenChecker();

  // somewhere after open("http://..."):
  getSelenideProxy().getProxy().addRequestFilter(authenticityTokenChecker);
}
```

Currently you can only add listeners AFTER opening a browser, which is sometimes inconvenient.
I hope we will implement adding listeners at any moment in next Selenide release.  

<br/>

#### Step 3. Implement AuthenticityTokenChecker

```java
import com.codeborne.selenide.Configuration;
import io.netty.handler.codec.http.*;
import net.lightbody.bmp.filters.*;
import net.lightbody.bmp.util.*;

public class AuthenticityTokenChecker implements RequestFilter {
  private final HttpClient httpClient = HttpClient.newBuilder().build();

  private final List<String> unprotectedUrls = new ArrayList<>(1);

  public void reset() {
    unprotectedUrls.clear();
  }

  public List<String> getUnprotectedUrls() {
    return unprotectedUrls;
  }

  @Override
  public HttpResponse filterRequest(HttpRequest httpRequest, HttpMessageContents contents, HttpMessageInfo httpMessageInfo) {
    if (httpRequest.getMethod() != HttpMethod.POST) return null;                   // ignore non-POST requests
    if (!httpRequest.getUri().startsWith(Configuration.baseUrl)) return null;      // ignore chrome requests to google.com etc.
    if (this url can work without authenticityToken) return null;                  // some post requests don't need csrf protection

    String body = contents.getTextContents();
    if (!body.contains("authenticityToken=")) {
      unprotectedUrls.add("No 'authenticityToken=' found for " + httpRequest.getUri() + " in " + body);
      return null;
    }

    sendHackedPostRequest(httpRequest, contents);
    return null;
  }
}
```

Note that `return null;` means "do not modify the request", which means that the browser
will still send the original request, and the normal flow of your test will not be affected.

<br/>

#### Step 4. Send hacked POST request

```java

  private void sendHackedPostRequest(HttpRequest httpRequest, HttpMessageContents contents) throws IOException, InterruptedException {
    // You need to tune this line. 
    // The request format (including name of parameter "authenticityToken") may depend on your application.
    // Note that the request can contain several "authenticityToken" parameters (immediatelly throw an error if they are different).
    // If the request contains a submitted form, especially with uploaded files, you need to modify "authenticityToken" a little bit differently. 
    String hackedBody = contents.getTextContents()
        .replace("authenticityToken=1234567890").to("authenticityToken=hack-me-if-you-can");

    java.net.http.HttpRequest.Builder builder = java.net.http.HttpRequest.newBuilder()
      .uri(URI.create(httpRequest.getUri()))
      .timeout(Duration.ofSeconds(1));

    for (Map.Entry<String, String> header : httpRequest.headers()) {
      if (!restrictedHeaders.contains(header.getKey().toLowerCase())) {
        builder.header(header.getKey(), header.getValue());
      }
    }

    java.net.http.HttpRequest request = builder
      .POST(java.net.http.HttpRequest.BodyPublishers.ofString(hackedBody))
      .build();

    log.info("Sending hacked request to {}", httpRequest.getUri());

    java.net.http.HttpResponse<String> httpResponse = httpClient.send(request, java.net.http.HttpResponse.BodyHandlers.ofString());

    if (httpResponse.statusCode() == 403) {
      log.info("Hacked request was rejected: {} {}", httpResponse.statusCode(), httpRequest.getUri());
    }
    else {
      log.error("HACK SUCCEEDED {} {}", httpResponse.statusCode(), httpRequest.getUri());
      unprotectedUrls.add("Detected URL without authenticity token check: " + httpRequest.getUri());
    }
  }

  private static final Set<String> restrictedHeaders = Set.of("connection", "content-length",
    "date", "expect", "from", "host", "upgrade", "via", "warning");

```

This implementation uses Java 11 built-in `HttpClient`. If you are that poor guy that still uses Java 8, you can easily
 replace it with OkHttp, Apache Http Client or some similar http client. 

<br/>

#### Step 5. Fail the test if some hacked request hasn't got "Forbidden" error

```java
abstract class BaseTest {
  @Before void resetChecker() {
    authenticityTokenChecker.reset();
  }

  @After
  public void verifyThatAllPostRequestsAreProtectedWithAuthenticityToken() {
    if (!authenticityTokenChecker.getUnprotectedUrls().isEmpty()) {
      fail(String.valueOf(authenticityTokenChecker.getUnprotectedUrls()));
    }
  }
}
```

<br/>

## What's now?

We managed to automatically check if our application is protected against CSRF attacks.  
(It's not theoretical: we actually did it in one project and found two vulnerabilities in a real internet-bank.) 

It's good, but it's not enough. There is a lot of other security attacks. 

Keep track of [OWASP 10](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project), think creatively,
and try to figure out how you could emulate other attacks with your automated tests. 

<br/>


<br>
[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org
