---
layout: post
title: "Year summary"
description: ""
category:
header-text: "2024"
tags: []
---
{% include JB/setup %}

Happy New Year!

Damn 2024 is finally over, time to take stock of the year.

* [Milestones](#milestones)
* [Elves](#committers)
* [Wizards](#playwrightium)
* [Palantirs](#videos)
* [Tribes](#companies)
* [People](#statistics)

## Milestones {#milestones}
This year we have released 18 versions (from 7.0.5 to 7.6.1) and implemented several important features:
* [Video recorder](/2024/11/24/selenide-7.6.0/#video-recorder)
* [Downloading files from Selenium Grid](/2024/02/27/selenide-7.2.0/#download-files-to-folder-in-selenium-grid)
* [New way to download files via CDP](/2024/02/07/selenide-7.1.0/#download-files-with-cdp) - and also [for Grid and Selenoid](/2024/02/27/selenide-7.2.0/#download-files-remotely-with-cdp)
* [Open browser with a new configuration](/2024/09/15/selenide-7.5.0/#new-configuration-for-every-browser)
* Finally, [abused Selenide ¯¯_(ツ)_/¯¯](/2024/02/07/selenide-7.1.0/#if-with-timeout)

<br>

## Elves {#committers}

These guys have been working tirelessly all year and putting presents under the tree.
This job is extremely important for the project, despite the fact that their names are often not even visible in 
press releases, because many of these changes are internal or too technical. Sometimes they don't even get merged at all.

But it is on them that Selenide rests!

#### Serhii Bryt

{: .list-right }
- [Downloading files using CDP](https://github.com/selenide/selenide/pull/2567)
- [Video recorder](https://github.com/selenide/selenide/pull/2768)
- Post [What you didn't know about Selenide](https://dou.ua/forums/topic/51075/)

{: .after-list-right }
&nbsp;

#### Boris Osipov

{: .list-right }
- [Animated Condition](https://github.com/selenide/selenide/pull/2556)
- [Run appium test on Browserstack](https://github.com/selenide/selenide/pull/2820)
- [Fix deprecated github actions](https://github.com/selenide/selenide/pull/2826)
- Code review for [PR 2801](https://github.com/selenide/selenide/pull/2801/files)
- Code review for [PR 2567](https://github.com/selenide/selenide/pull/2567/files)
- Code review for [PR 2768](https://github.com/selenide/selenide/pull/2768)

{: .after-list-right }
&nbsp;

#### Petro Ovcharenko

{: .list-right }
- [Fix remote Appium browser](https://github.com/selenide/selenide/pull/2664)
- [add method `WebDriverRunner. setDriver`](https://github.com/selenide/selenide/pull/2666)
- [fix before/after events order](https://github.com/selenide/selenide/pull/2672)
- [Fix CDP download for custom browsers](https://github.com/selenide/selenide/pull/2728)
- [Fix problem with AppiumPageFactory](https://github.com/selenide/selenide/pull/2879)
- [fix double click with appium](https://github.com/selenide/selenide/pull/2905)

{: .after-list-right }
&nbsp;

#### Yaraslau Lazakovich

{: .list-right }
- [Bump checkstyle to 10.17.0](https://github.com/selenide/selenide/pull/2753)
- [bump Gradle to 8.11.1](https://github.com/selenide/selenide/pull/2899)

{: .after-list-right }
&nbsp;

#### Aliaksandr Rasolka

{: .list-right }
- [Add getSearchLocator command](https://github.com/selenide/selenide/pull/2593)
- [Add dom attribute and property conditions](https://github.com/selenide/selenide/pull/2783)

{: .after-list-right }
&nbsp;

#### donnieHub

{: .list-right }
- [added method `$.scroll()`](https://github.com/selenide/selenide/pull/2809)

{: .after-list-right }
&nbsp;

#### Daniil Moiseev

{: .list-right }
- [Support special space chars](https://github.com/selenide/selenide/pull/2858)
- [add `because` function](https://github.com/selenide/selenide/pull/2853)

{: .after-list-right }
&nbsp;

#### Erik Jõgi & Vlad Ogorodnik:

{: .list-right }
- [`input` event from `select`](https://github.com/selenide/selenide/pull/2813)

{: .after-list-right }
&nbsp;

#### Amuthan Sakthivel:

{: .list-right }
- Talk [Mutated Java Appium Client - Selenide Appium](https://www.youtube.com/watch?v=C8rUqOUhxIo&ab_channel=ConfEngine) at AppiumConf 2024

{: .after-list-right }
&nbsp;

Reviewing pull requests, criticizing changes, describing bugs - this is a lot of work, actually!  
This work is invisible, but important.

Thanks to all of you!

<br>

## Wizards {#playwrightium}

A significant event for Selenide is the appearance of the [Playwrightium](https://www.youtube.com/watch?v=Mn7pP_jHJEE&ab_channel=ConfEngine).

Playwright is currently on hype, we must admit.
And people now have the opportunity to continue using Selenide, and change the implementation under the hood:
on even days Selenium, on odd Playwright - as the devil takes them. :)

And again, thanks to [Sergey Brit](https://github.com/britka) for [Playwrightium](https://github.com/britka/playwrightium)!

<br>

## Palantirs {#videos}
* This year, an important event happened for me: at the SeleniumConf conference, a report was given titled "[How to migrate from Selenium to Selenide](https://www.youtube.com/watch?v=roL1ciaNWtY&list=PL9Z-JgiTsOYRJCXuEOGXLH1w1oImoprnq&ab_channel=ConfEngine)". Imagine what a turn it is! :)
* And what's also great is that at another automation conference LambdaTest [I talked about Selenide](https://www.youtube.com/watch?v=CKSl2NRrMVg&ab_channel=LambdaTest)

Unfortunately, I manage to give presentations in English much less often than in Russian, so these two are an achievement.
Selenide's audience is growing [all over the world](/users.html#all). :)

By the way, this year we found videos about Selenide [in Spanish](https://www.youtube.com/watch?v=j-uaUwoo90k&ab_channel=JoseDiaz) and also [in Turkish](https://www.youtube.com/watch?v=zDw0iGdSghY&ab_channel=TechProEducationTR)!

<br>

## Tribes {#companies}

This year I got around to adding a little to the list of companies using Selenide.  
It was surprising that there is more companies from [America](/users.html#usa),
[Europe](/users.html#europe) and
[other word](/users.html#asia) than I assumed!

<br>

## People {#statistics}

The monthly number of downloads has broken a new record, rising from 877K last January to 1.3 million in October.

<center>
  <img src="{{ BASE_PATH }}/images/2024/11/selenide.downloads.png" width="800"/>
</center>

<br>

Happy New Year to you, and may no orcs cross your path!

<br>

[Andrei Solntsev](http://asolntsev.github.io/)

selenide.org

<style>
  .blog_post_content h4 {
    float: left;
    max-width: clamp(100px, 20vw, 200px);
  }
  .blog_post_content .list-right {
    float: right;
    width: clamp(100px, 32vw, 300px);
  }
  .blog_post_content .after-list-right {
    clear: both;
    height: 1px;
  }
</style>