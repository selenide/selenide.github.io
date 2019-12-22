---
layout: post
title: "De"
description: "Defaŭlta lingvo"
category:
header-text: "Selenide Advent Calendar<br/>Day 22"
tags: []
---
{% include JB/setup %}

# Defaŭlta lingvo

The name of todays topic is Esperanto and traslates as "default language".

You may have noticed that some web appications or sites change their language depending on either your browser languange setting or on your location.

## Problem
In case you have international developers in your team all writing and running some tests on different computer, you also may have noticed that the very same tests is failing or passing because the applications was displayed in different languages on different machines.
If the application decides about the language based on user location, it can be difficult to write stable tests running everywhere. But if it is just "preferred browser language of the user", then your task is much easier.

## Solution

So if you have a test which is supposed to run with language that differs from the default language of your browser, you have folowing options:
Let's imagine you are writing the tests for German Locale.

1. Change the default language of you operational system. Poor you. Now the most of the programs will be showing in German. Ordnung muss sein!
2. Take your browser and setup it to be German the preferable languge. Save away the profile. Google and experiment a lot about loading custom browser profile before starting your tests. Don't forget to remove German from the top of preferred languages or otherwise, you know already, Ordnung....
3. Just make use of Chrome preference "intl.accept_languages" and set it to "de" (for German).

Of course you can very easily do it in Selenide.
Setup the system variable `chromeoptions.prefs=intl.accept_langugages=de`

You can do it either in code:
```java
System.setProperty("chromeoptions.prefs","intl.accept_langugages=de");
```
or even better in configuration file of Maven or Gradle

### Maven 

maven `pom.xml`
```xml
  ...
  <plugin>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>2.xx.yy</version>
        <configuration>
          <systemPropertyVariables>
            ...
            <chromeoptions.prefs>intl.accept_langugages=de</chromeoptions.prefs>
          </systemPropertyVariables>
        </configuration>
    </plugin>
    ...
```

### Gradle

likewise for gradle in `gradle.properties` (you additionally need a line or two in `build.gradle` to get this parameter transfered in to the test task in gradle)
```properties
systemProp.chromeoptions.prefs=intl.accept_languages=de
```

You can then override the setting running `mvn test` or `gradle test` defining another value in the command line `-Dchromeoptions.prefs=intl.accept_languages=ru`


## Example

Just run this short test and see the effect of different language settings.

```java
open("http://wikipedia.org");
$("[data-jsl10n=slogan]").shouldHave(exactText("Die freie Enzyklopädie"));
```

I wish you all Fröhliche Weihnachten and Guten Rutsch! 

Alexei Vinogradov
