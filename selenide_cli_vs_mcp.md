Testing selenide-cli locally

1. Build the fat JAR (one-time, or after code changes):
   ./gradlew :modules:cli:shadowJar
   This produces modules/cli/build/libs/selenide-cli-<version>.jar (currently 7.18.0).

2. (Optional) Put a short launcher on your PATH:
   JAR=$(ls "$(pwd)"/modules/cli/build/libs/selenide-cli-*.jar)
   printf '#!/usr/bin/env bash\nexec java -jar "%s" "$@"\n' "$JAR" | sudo tee /usr/local/bin/selenide >/dev/null
   sudo chmod +x /usr/local/bin/selenide
   Without this, just replace selenide with java -jar modules/cli/build/libs/selenide-cli-*.jar everywhere below.

3. Drive a real browser. I just ran this exact sequence and it worked end-to-end:
   selenide open --headless --browser=chrome https://the-internet.herokuapp.com/login
   selenide setValue "#username" tomsmith
   selenide setValue "#password" "SuperSecretPassword!"
   selenide click "button[type=submit]"
   selenide should "text=You logged into a secure area!" visible
   selenide code     # prints generated Selenide Java
   selenide close
   Output was a clean, runnable Java snippet (imports + 4 lines). Drop --headless to actually watch the browser.

One caveat I hit: the README/build doc also documents a faster dev loop, ./gradlew :modules:cli:runCli -PcliArgs="open ..." (runs straight from compiled classes, no jar rebuild needed). On this repo's current Gradle (9.5.1) it's actually broken — errors with Could not set unknown property 'args' for task ... of type JavaExec. Looks like a Gradle-version drift in modules/cli/build.gradle's runCli task registration, not something either of us just introduced. Stick to the jar approach above for now; happy to fix runCli separately if you want it working.

Other useful things for testing:
- selenide -s <name> open <url> — named parallel sessions (own cookies/storage/recording)
- selenide list / selenide close-all — manage sessions
- selenide save build/Flow.java — daemon writes generated code straight to a file
- Logs live at ~/.selenide-cli/<session>.log if something misbehaves
- To validate correctness rather than poke at it manually: ./gradlew :modules:cli:check (unit, no browser) and ./gradlew :modules:cli:chrome_headless (real end-to-end test)

Blog post material — fun demo targets

the-internet.herokuapp.com (a QA practice site) is a goldmine for this:
- /disappearing_elements — record a click, then watch the generated should(...) assertion flake because the element that was there a second ago is now gone
- /dynamic_loading — CLI waits for a spinner to disappear, generates the exact shouldBe(visible) wait for it
- /hovers — selenide hover revealing a hidden caption, funny because the generated code reads like a stage direction
- /key_presses, /drag_and_drop, /javascript_alerts — each makes for a good "here's the one-liner it turns into" bit
- /entry_ad — closing an annoying modal ad, a relatable gag
- A "rickroll" bit: selenide open a YouTube link, selenide code, and name the generated method something like neverGonnaGiveYouUp() in the write-up

If you want, I can run a few of these live and paste the actual generated code/output for whichever ones you want to feature — just say which pages.
