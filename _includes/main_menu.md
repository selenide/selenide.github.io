<div class="main-menu">

  <div class="service-links">
    <div id="languages">
      <a id="lang_eng" href="https://selenide.org">EN</a>
      <a id="lang_rus" href="https://ru.selenide.org">RU</a>
    </div>
  </div>

  <div class="main-menu-pages">
    <a href="{{ BASE_PATH }}/quick-start.html">Quick start</a>
    <a href="{{ BASE_PATH }}/documentation.html">Docs</a>
    <a href="{{ BASE_PATH }}/faq.html">FAQ</a>
    <a href="{{ BASE_PATH }}/blog.html">Blog</a>
    <a href="{{ BASE_PATH }}/javadoc.html">Javadoc</a>
    <a href="{{ BASE_PATH }}/users.html">Users</a>
    <a href="{{ BASE_PATH }}/quotes.html">Quotes</a>
  </div>

  {% if page.show_news %}
    <div class="news">
      <div class="news-line news-title"><a href="/2023/03/23/selenide-6.12.4/">Released Selenide 6.12.4</a></div>
      <div class="news-line news-link">Support for jdk-http-client</div>
    </div>
  {% endif %}

</div>
