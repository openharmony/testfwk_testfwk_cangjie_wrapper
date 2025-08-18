# testfwk_cangjie_wrapper

## Introduction

The testfwk_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the arkXtest. arkXtest, the automated test framework of OpenHarmony, consists of the JS unit test framework (JsUnit) and UI test framework (UiTest).

JsUnit provides APIs for writing test cases for system or application interfaces, executing unit test cases, and generating test reports.

UiTest provides simple and easy-to-use APIs for locating and operating UI components, helping users to develop automatic test scripts based on UI operations.

**Figure 1** testfwk_cangjie_wrapper architecture

![](figures/testfwk_cangjie_wrapper_architecture_en.png "testfwk_cangjie_wrapper architecture")

## Directory Structure

```
test/testfwk/testfwk_cangjie_wrapper
├── ohos             # Cangjie arkXtest code
├── kit              # Cangjie kit code
```

## JsUnit Features

| No.  | Feature    | Description                                                    |
| ---- | -------- | ------------------------------------------------------------ |
| 1    | Basic process support| Provides APIs for writing and executing test cases.                                    |
| 2    | Assertion library  | Provides APIs for checking whether the actual value of a test case is the same as the expected value.                        |
| 3    | Mock| Provides APIs for mocking functions to return the specified value or perform the specified action.|
| 4    | Data driving| Provides APIs for reusing a test script with different input data.|

## Repositories Involved

[arkXtest](https://gitee.com/openharmony/testfwk_arkxtest/blob/master/README_en.md)
