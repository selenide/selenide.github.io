# otherwise Jekyll doesn't re-load users.json
rm -fr _site/users.html

rvm use 2.7

bundle exec jekyll serve --future --incremental --safe --strict_front_matter \
  --host=0.0.0.0 --port=4001 \
  --livereload --livereload-port=40001 \
  --watch \
  --open-url
