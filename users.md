---
layout: default
title : Selenide users
header : Who uses Selenide
group: navigation
cssClass: testimonials
header-text:
---
{% include JB/setup %}

{% include themes/ingmar/_title.html %}

<br/>

<div class="wrapper">
  <div id="user-tags">
    <a href="#" class="reset-filter">all</a>
    {% for tag in site.data.user-tags %}
      | <a href="#" class="tag">{{ tag }}</a>
    {% endfor %}
  </div>
</div>

<div class="wrapper-content" id="selenide-users">

  <section>

    {% for user in site.data.users %}
      {% if user.name != '' %}
        <div class="user {% for tag in user.tags %} {{ tag }}{% endfor %}">
          <div class="user-logo">
            <a href="{{ user.link }}" target="_blank">
              <img src="{{ BASE_PATH }}/images/{{ user.logo }}" alt="{{ user.name }}" {% if user.logoWidth %}width="{{ user.logoWidth }}"{% endif %}/>
            </a>
          </div>
          <div class="user-description">
            <a href="{{ user.link }}" target="_blank">{{ user.name }}</a> - {{ user.description }}
          </div>
          <hr class="divider"/>
        </div>
      {% endif %}
    {% endfor %}

  </section>
</div>

<div class="vspace"></div>

<a name="thanks"></a>

<div class="short feedback">
  <div class="wrapper-color-content">
    <h3>We say THANKS:</h3>
  </div>
</div>

<div class="wrapper-content">
  <section>

    <h3>YourKit</h3>
    
    <div>YourKit is kindly supporting Selenide project with its full-featured Java Profiler.</div>
    
    <div>
      YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. 
      Take a look at YourKit's leading software products:
      <a href="https://www.yourkit.com/java/profiler/features/" target="_blank">YourKit Java Profiler</a> and 
      <a href="https://www.yourkit.com/.net/profiler/features/" target="_blank">YourKit .NET Profiler</a>.
    </div>
    
    <div class="center">
      <br/>
      <img src="{{BASE_PATH}}/images/yourkit.png" target="_blank" alt="YourKit" style="width: 150px;"/>
    </div>

    <h3>Selenium</h3>
    
    <div>And of course, the <a href="http://www.seleniumhq.org/" target="_blank">Selenium WebDriver</a>!</div>
    
    <div class="center">
      <br/>
      <img src="{{BASE_PATH}}/images/selenium-logo.png" alt="Selenium WebDriver" style="width: 150px;"/>
    </div>

  </section>
</div>

<div class="vspace"></div>


<a name="contact"></a>

<div class="short howto">
  <div class="wrapper-color-content">
    <h3>Tell us about yourself!</h3>
    <h4>Share your experience with others!</h4>
  </div>
</div>

<div class="wrapper-content center">
  <section>
    <br/>
    <div>Want to see your logo on this page? <a href="mailto:andrei.solntsev@gmail.com">Email us!</a></div>
    <div>We really want to know more about you: tell what you tried, what succeeded, what failed.</div>
    <br/>
    <div>Ask questions or give a feedback!</div>
  </section>
</div>

<div class="quicklinks">
  <div class="wrapper-color-content">
    <ul class="gray-boxes">
      <li>
        <a href="mailto:selenide@googlegroups.com" target="_blank">
          <span class="ql"><h3>Ask</h3> <strong><h4>people</h4></strong></span>
        </a>
      </li>
      <li>
        <a href="https://groups.google.com/forum/?fromgroups#!forum/selenide" target="_blank" title="Selenide googlegroup archive">
          <span class="ql"><h3>Read</h3> <strong><h4>GGroup</h4></strong></span>
        </a>
      </li>
      <li>
        <a href="mailto:andrei.solntsev@gmail.com" target="_blank">
          <span class="ql"><h3>Email</h3> <strong><h4>me</h4></strong></span>
        </a>
      </li>
      <li>
        <a href="https://twitter.com/selenide" target="_blank" title="Twitter #selenide">
          <span class="ql"><h3>Write to</h3> <h4>twitter</h4></span>
        </a>
      </li>
    </ul>
  </div>
</div>


{% include JB/comments %}
