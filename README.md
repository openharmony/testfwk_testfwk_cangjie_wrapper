# testfwk_testfwk_cangjie_wrapper

## Introduction

The testfwk_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the arkXtest. arkXtest, the automated test framework of OpenHarmony, consists of the Cangjie unit test framework (CjUnit) and UI test framework (UiTest).

CjUnit provides APIs for writing test cases for system or application interfaces, executing unit test cases, and generating test reports.

UiTest provides simple and easy-to-use APIs for locating and operating UI components, helping users to develop automatic test scripts based on UI operations.

## System Architecture

**Figure 1** testfwk_cangjie_wrapper architecture

![testfwk_cangjie_wrapper architecture](figures/testfwk_cangjie_wrapper_architecture_en.png "testfwk_cangjie_wrapper architecture")

## Directory Structure

```cangjie
test/testfwk/testfwk_cangjie_wrapper
├── figures          # architecture pictures
├── kit              # Cangjie kit code
└── ohos             # Cangjie arkXtest code
```

## Constraints

The currently open UiTest apis only support standard devices.

## Usage

The following features are provided:

- Driver provides the UI test entry. It provides APIs for locating a component, checking whether a component exists, and injecting a key.
- On describes the attributes (such as text, ID, and type) of UI components, Driver locates the component based on the attributes described by On.
- Component provides the UI component object, which provides APIs for obtaining component attributes, clicking a component, and scrolling to search for a component.
- UiWindow provides the window object, which provides APIs for obtaining window attributes, dragging a window, and adjusting the window size.

For relevant API of UiTest, please refer to [ohos.ui_test (UI Testing)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/TestKit/cj-apis-ui_test.md); for relevant guidelines, please refer to Automated Test Framework Usage Guide.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[arkXtest](https://gitee.com/openharmony/testfwk_arkxtest/blob/master/README_en.md)
