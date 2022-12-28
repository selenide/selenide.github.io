---
layout: default
title: "Selenide: concise UI tests in Java"
tagline:
show_news: true
---
{% include JB/setup %}
{% include donate %}

<div class="short wiki">
  <div class="wrapper-color-content">
    <h3>What is Selenide?</h3>
    <h4>Selenide is a framework for test automation powered by <a href="https://docs.seleniumhq.org/projects/webdriver/" target="_blank">Selenium WebDriver</a> that brings the following advantages:</h4>
    <div class="highlights">
      <a href="/documentation.html">Concise fluent API for tests</a>
      <span>Stable tests</span>
      <span>Powerful selectors</span>
      <span>Simple configuration</span>
    </div>
    <div class="mt-1">
      You don't need to think how to shut down browser, handle timeouts and StaleElement Exceptions or search for relevant log lines, debugging your tests.
    </div>
    <div class="mt-1">
      <b> Just focus on your business logic and let Selenide do the rest! </b>
    </div>

    <a href="/quick-start.html">
      <img style="margin-top: 15px; margin-bottom: -33px" src="{{ BASE_PATH }}/images/arrow-down.png" width="30" height="55" border="0"/>
    </a>
  </div>
</div>

{% include themes/ingmar/_quicklinks.html %}


<div class="short howto">
  <div class="wrapper-color-content">
    <h3>Quick start</h3>
    <h4>It's extremely easy to start using Selenide. Definitely not a rocket science.</h4>

    <div>
      Just add <a href="https://search.maven.org/remotecontent?filepath=com/codeborne/selenide/{{site.SELENIDE_VERSION}}/selenide-{{site.SELENIDE_VERSION}}.jar">selenide.jar</a> to your project and you are done.
    </div>
    <div>
      See Quick start guide for more details.
    </div>

    <a href="{{ BASE_PATH }}/quick-start.html">
      <img style="margin-top: 15px; margin-bottom: -33px" src="{{ BASE_PATH }}/images/arrow-down.png" width="30" height="55" border="0"/>
    </a>
  </div>
</div>

<div class="short docs">
  <div class="wrapper-color-content">
    <h3>Documentation</h3>
    <h4>
      Poor software <span class="bold">doesn't have</span> documentation.
      Brilliant software <span class="bold">doesn't need</span> documentation.
    </h4>

    <div>
      We are proud to claim that Selenide is so simple that you don't need to read tons of documentation.
    </div>
    <div class="mt-1">
      The whole work with Selenide consists of three simple things!
    </div>
    <a href="{{ BASE_PATH }}/documentation.html">
      <img style="margin-top: 15px; margin-bottom: -33px" src="{{ BASE_PATH }}/images/arrow-down.png" width="30" height="55" border="0"/>
    </a>

  </div>
</div>

<div class="short feedback">
  <div class="wrapper-color-content">
  
    <h3>Contacts</h3>
    <h4>Do you want to talk about it?</h4>
  
    <div>Where You can ask question or discuss any topic about Selenide in English:</div>
    <div class="highlights">
      <a href="mailto:selenide@googlegroups.com">Google group</a>
      <a href="mailto:info@selenide.org">Email</a>
    </div>
  
  </div>
</div>

<div class="short testimonials">
  <div class="wrapper-color-content">
    <h3>Testimonials</h3>
    <h4>"Selenide is really nice and capable tool for writing functional/acceptance tests for your browser-based UI. I encourage you to check Selenide out and give it a try."</h4>

    <div>KAUR MÄTAS,</div>
    <div>LiveRebel engineer at ZeroTurnaround</div>

    <a href="{{ BASE_PATH }}/users.html">
      <img style="margin-top: 15px; margin-bottom: -33px" src="{{ BASE_PATH }}/images/arrow-down.png" width="30" height="55" border="0"/>
    </a>
  </div>
</div>

<div class="short">
  <a class="twitter-timeline" href="https://twitter.com/selenide" data-widget-id="397446026996359168">Tweets by @selenide</a>
  <script>
    $(function() {
      !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
    });
  </script>
</div>

<a name="thanks"></a>
<div class="short thanks">
  <h4>Many thanks to:</h4>
  <a href="https://www.jetbrains.com/?from=selenide.org"><img src="{{BASE_PATH}}/images/jetbrains.svg" alt="JetBrains. Intellij IDEA - the best Java IDE on the Milky Way!"></a>
  <img src="{{BASE_PATH}}/images/yourkit.png" alt="YourKit" style="width: 150px;"/>
  <img src="https://www.browserstack.com/images/mail/browserstack-logo-footer.png" alt="BrowserStack"/>
</div>
