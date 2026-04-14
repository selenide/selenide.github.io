=======
selenide-web
===========

Selenide website (English): selenide.org

Built with [Hugo](https://gohugo.io/) static site generator, hosted on GitHub Pages.


### For developers:

```bash
# Install Hugo (macOS)
brew install hugo

# Start local dev server
./start.sh
# or manually:
hugo server --buildFuture --port 4001
```

Open [http://localhost:4001](http://localhost:4001) in browser.


### Release process
Just run script:
selenide> ./release 6.1.0

This script will:
1. add tag "v${version}"
2. build & run unit-tests
3. publish selenide-*jar to oss.sonatype.org
4. generate javadoc for site
