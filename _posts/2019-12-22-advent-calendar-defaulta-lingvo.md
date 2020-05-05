---
layout: post
title: "Defaŭlta lingvo"
description: "How to define the default language"
category:
header-text: "Selenide Advent Calendar<br/>Day 22"
tags: []
---
{% include JB/setup %}

# Defaŭlta lingvo

The name of today's topic is Esperanto and translates as "default language".

You may have noticed that some web applications or sites change their language depending on either your browser language setting or on your location.

## Problem
In case you have international developers in your team all writing and running some tests on different computer, you also may have noticed that the very same tests is failing or passing because the applications was displayed in different languages on different machines.

If the application decides about the language based on user location, it can be difficult to write stable tests running everywhere. But if it is just "preferred browser language of the user", then your task is much easier.

## Solution

So if you have a test which is supposed to run with language that differs from the default language of your browser, you have following options. Let's imagine you are writing the tests for _German_ Locale.

- Change the default language of you operational system. Poor you. Now the most of the programs will be showing in German. _**Ordnung muss sein!**_
- Take your browser and setup it to be German the preferable language. Save away the profile. Google and experiment a lot about loading custom browser profile before starting your tests. Don't forget to remove German from the top of preferred languages or otherwise, you know already, _**Ordnung....**_
- Just make use of Chrome preference "intl.accept_languages" and set it to "de" (for German).

Of course you can very easily do it in Selenide.
Setup the system variable `chromeoptions.prefs=intl.accept_languages=de`

You can do it either in code:
```java
System.setProperty("chromeoptions.prefs","intl.accept_languages=de");
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
            <chromeoptions.prefs>intl.accept_languages=de</chromeoptions.prefs>
          </systemPropertyVariables>
        </configuration>
    </plugin>
    ...
```

### Gradle

likewise for gradle in `gradle.properties` (you additionally need a line or two in `build.gradle` to get this parameter transferred in to the test task in gradle)
```properties
systemProp.chromeoptions.prefs=intl.accept_languages=de
```

### Command-line

You can then override the setting running `mvn test` or `gradle test` defining another value in the command line `-Dchromeoptions.prefs=intl.accept_languages=ru`


## Example

Just run this short test and see the effect of different language settings.

```java
open("http://wikipedia.org");
$("[data-jsl10n=slogan]").shouldHave(exactText("Die freie Enzyklopädie"));
```

I wish you all _**Fröhliche Weihnachten**_ and _**Guten Rutsch**_! 

**Alexei Vinogradov**
