---
layout: page
title :
header : Screenshots
group: navigation
cssClass: docs
header-text: >
  <h4>Documentation</h4>
  
  Screenshots
---
{% include JB/setup %}

{% include documentation-menu.md %}

## Can Selenide take screenshots?

Yes, Selenide takes screenshots **automatically** on every test failure. This is very useful for error analysis.

By default Selenide puts screenshots to folder `build/reports/tests`.


### Can I tell Selenide to put screenshots to a specific folder?

Yes. 
You can use property `-Dselenide.reportsFolder=test-result/reports` to set any directory to store screenshots to.
For v4.x use `-Dselenide.reports=test-result/reports`

Another option is to set this folder directly from your code:

```java
Configuration.reportsFolder = "test-result/reports";
```


## JUnit and TestNG support

For JUnit and TestNG, there is a special support for taking screenshots also on successful tests.  

Let me remind: normally you don't need to setup screenshots in most cases because Selenide automatically takes 
a screenshot when some of its checks like `$.shouldBe(..)` fails.  

But if you want to also automatically take screenshots
1. in case of successful tests, or
2. if some of non-Selenide check fails (like `assertEquals` or `assertThat`),

then you can do it by adding couple of lines. See below. 

### For JUnit 4:

To automatically take screenshot of every failed test:

```java
import com.codeborne.selenide.junit.ScreenShooter;

public class MyTest {
  @Rule
  public ScreenShooter makeScreenshotOnFailure = ScreenShooter.failedTests();

  // ...
}
```

To take screenshot of every test (even succeeded), use the following command:

```java
@Rule
public ScreenShooter makeScreenshotOnFailure = ScreenShooter.failedTests().succeededTests();
```


### For TestNG:

```java
import com.codeborne.selenide.testng.ScreenShooter;

@Listeners({ ScreenShooter.class})
public class MyTest {
  // ...
}
```

To automatically take screenshots after every test (even succeeded), execute the following command before running tests:
```java
ScreenShooter.captureSuccessfulTests = true;
```

### For JUnit 5:

#### How to use in Java:

```java
  @ExtendWith({ScreenShooterExtension.class})
  public class MyTest {
    // ...
  }
```

How to use in Java (with customization):
```java
  public class MyTest {
    @RegisterExtension
    static ScreenShooterExtension screenshotEmAll = new ScreenShooterExtension(true).to("target/screenshots");
  }
```

#### How to use in Kotlin:
```kotlin
  @ExtendWith(ScreenShooterExtension::class)
  class MyTest {
    // ...
  }
``` 
 
How to use in Kotlin (with customization):

```kotlin
  class MyTest {
    companion object {
      @JvmField
      @RegisterExtension
      val screenshotEmAll: ScreenShooterExtension = ScreenShooterExtension(true).to("target/screenshots");
    }
  }
```

### At any moment you wish
Additionally, you can take screenshot at any moment with a single line of code:

```java
import static com.codeborne.selenide.Selenide.screenshot;

String pngFileName = screenshot("my_file_name");
```

Selenide will create two files: `my_file_name.png` & `my_file_name.html`

Later we also added a method that can return a screenshot in a desired format (`BASE64`, `BYTES` or `FILE`):

```java
String screenshotAsBase64 = Selenide.screenshot(OutputType.BASE64);
byte[] decoded = Base64.getDecoder().decode(screenshotAsBase64);
```

