<ul class="main-menu-pages">
  <li><a href="{{ BASE_PATH }}/quick-start.html">Quick start</a></li>
  <li><a href="{{ BASE_PATH }}/documentation.html">Docs</a></li>
  <li><a href="{{ BASE_PATH }}/faq.html">FAQ</a></li>
  <li><a href="{{ BASE_PATH }}/blog.html">Blog</a></li>
  <li><a href="{{ BASE_PATH }}/javadoc.html">Javadoc</a></li>
  <li><a href="{{ BASE_PATH }}/users.html">Users</a></li>
  <li><a href="{{ BASE_PATH }}/quotes.html">Quotes</a></li>
</ul>

<div class="news">
  <div class="news-line"><a href="/2021/07/05/selenide-5.22.3/">Released Selenide 5.22.3</a></div>
  <div class="news-line">Fresh and delicious bugfixes</div>
</div>

<h3 style="display:none">Blog</h3>
<div class="archive" style="display:none">
  {% assign posts_collate = site.posts %}
  {% include JB/posts_collate %}
  <a href="{{ BASE_PATH }}/archive.html" class="right small">Blog archive</a>
</div>
