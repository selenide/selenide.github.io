---
layout: page
title :
header : Reports
group: navigation
cssClass: docs
header-text: >
  <h4>Documentation</h4>
  
  Reports
---
{% include JB/setup %}

{% include documentation-menu.md %}

<br>

#### [&gt; YAGNI](#yagni)
#### [&gt; Text report](#text-report)
#### [&gt; Allure report](#allure-report)

<a name="yagni"></a>
## YAGNI

First of all, please think twice: probably you don't need any specific reports.  

Both Gradle and Maven already generate good enough test report which includes all the errors.  
When a test fails, Selenide already generates a detailed error message 
(including [screenshot](/documentation/screenshots.html) and html of a page). 
Typically, it's enough to understand why the test failed:

```
Element should be hidden {#gameWin}
Element: '<img class="gameOver" id="gameWin" src="img/thumbs-up.jpeg"></img>'

Screenshot: file:/.../hangman/build/reports/tests/1510751914648.0.png
Page source: file:/.../hangman/build/reports/tests/1510751914648.0.html
Timeout: 4 s.
```
  
<br/>

If you still want to get reports, we can suggest two options: "Text report" and "Allure report".  

<a name="text-report"></a>
## 1. Text report

It's a simple report built in Selenide which shows all steps that were performed during the test:

```
+----------------------+---------------------------------------------+--------+----------+
|Element               |Subject                                      |Status  |ms.       |
+----------------------+---------------------------------------------+--------+----------+
|open                  |http://localhost:2070/                       |PASSED  |4669      |
|open                  |http://localhost:2070/fakeLogin?username=bob |PASSED  |1324      |
|By.linkText: Quicky   |click()                                      |PASSED  |793       |
|#btn-message-reply    |click()                                      |PASSED  |1002      |
|By.name: message.text |should be(focused)                           |PASSED  |57        |
|By.name: message.text |should have(text 'long thread')              |PASSED  |47        |
|By.name: message.text |set value(Hello world!)                      |PASSED  |69        |
|#send-button          |click()                                      |PASSED  |1051      |
|.alert-success        |should be(visible)                           |PASSED  |71        |
+--------------------+-----------------------------------------------+--------+----------+
```

It looks simple, but contains all the needed information.  
To enable such a report, you need to 
1. [Setup slf4j](https://github.com/selenide/selenide/wiki/slf4j) in your project (slf4j is de-facto a standard logging tool in Java world).
2. Add extensions/rule/listener as shown below. 

#### For JUnit 5:

```java
  import com.codeborne.selenide.junit5.TextReportExtension;

  @ExtendWith({TextReportExtension.class})
  public class MyTest {
    // ...
  }
```

#### For JUnit 4:

```java
import com.codeborne.selenide.junit.TextReport;

public class MyTest {
  @Rule
  public TextReport textReport = new TextReport();

  // ...
}
```

#### For TestNG:

```java
import com.codeborne.selenide.testng.TextReport;

@Listeners({ TextReport.class})
public class MyTest {
  // ...
}
```


<a name="allure-report"></a>
## 2. Allure report

QA engineers often want to generate "beautiful" reports. It's for managers, they say.  
I am rather skeptical about those reports. I think managers don't really read those reports. Think twice before you 
spend your time on "beautifying" reports.   

If you still insist, you can setup Allure. It's a popular open-source reporting library from [Qameta Software](https://qameta.io/) company.  
It has built-in integration with Selenide. And yes, its reports look really nice. :)

You will need to
1. Add dependency `io.qameta.allure:allure-selenide:2.21.0` (or higher) to your project.
2. Add a line in the beginning of your tests:

```java
    @BeforeAll
    static void setupAllureReports() {
      SelenideLogger.addListener("AllureSelenide", new AllureSelenide());

       // or for fine-tuning:
      SelenideLogger.addListener("AllureSelenide", new AllureSelenide()
           .screenshots(false)
           .savePageSource(true)
      );
    }
```

See a sample project [Selenide+Allure](https://github.com/selenide-examples/selenide-allure-junit)

NB! Method `SelenideLogger.addListener` should be called in the same thread as test itself.
Some test frameworks might call `@BeforeAll` and `@Test` methods in different thread - in this case your listener will not get events from the test.
In such cases you probably need to move the abovementioned initialization block to `@Before` or even `@Test` method.

<br/>
<br/>

P.S. But please, PLEASE don't take BDD for nice reports! BDD is not intended for reports. 
BDD is a _development_ process. BDD will only create more problem for you if you only apply it technically, without changing the process. 

<br/>
