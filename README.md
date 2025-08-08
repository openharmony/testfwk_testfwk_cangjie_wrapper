# arkXtest

## Introduction

arkXtest, the automated test framework of OpenHarmony, consists of the JS unit test framework (JsUnit) and UI test framework (UiTest).

JsUnit provides APIs for writing test cases for system or application interfaces, executing unit test cases, and generating test reports.

UiTest provides simple and easy-to-use APIs for locating and operating UI components, helping users to develop automatic test scripts based on UI operations.

## Directory Structure

```
test/testfwk/testfwk_cangjie_api
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

**arkXtest**

testfwk_cangjie_api
