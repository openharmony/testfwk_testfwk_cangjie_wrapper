# testfwk_testfwk_cangjie_wrapper

## Introduction

The testfwk_testfwk_cangjie_wrapper is a UI test framework (UiTest) provided for developers using the Cangjie language for application development on OpenHarmony. The currently open testfwk_testfwk_cangjie_wrapper only supports standard devices.

## System Architecture

**Figure 1** testfwk_cangjie_wrapper architecture

![testfwk_cangjie_wrapper architecture](figures/testfwk_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram, the testfwk_testfwk_cangjie_wrapper provides UI test framework functions:

Interface Layer:
- UiTest: Provides developers with the ability to find and operate interface controls, supporting users in developing automated test scripts based on interface operations. Its supported functional features mainly include the following four types:
  - Driver: The entry point for UI test, providing developers with interface capabilities such as checking component existence, finding components, injecting key presses, clicking coordinates, sliding components, gesture operations, and screenshots.
  - On: Provides developers with rich component characteristic descriptions (text, ID, type, etc.) interface capabilities, used to match and find target components to operate or inspect. Supports matching single attributes and matching combinations of multiple attributes, with component attributes supporting multiple matching modes and relative positioning of components.
  - Component: Represents a control on the UI interface, generally found through the Driver.findComponent(on) method, providing developers with interface capabilities such as obtaining component properties, clicking components, sliding searches, and text injection.
  - UiWindow: Represents a window on the UI interface, generally found through the Driver.findWindow(WindowFilter) method, providing developers with interface capabilities such as obtaining window properties, dragging windows, and adjusting window size.

Framework Layer:

- UiTest Wrapper: Implements the UiTest wrapper based on the underlying arkxtest's UI test basic capabilities, providing a complete UI test framework through Driver class, On class, Component class, and UiWindow class.

Dependency Components Introduction in Architecture:

- arkxtest: Depends on the UI testing capabilities provided by the arkxtest.
- init: Depends on the system parameter query capabilities to determine if the current environment supports testing.
- ability_cangjie_wrapper: Depends on the AbilityDelegatorRegistry for initializing the UI testing framework.
- hiviewdfx_cangjie_wrapper: Depends on HiLog capabilities for printing logs at key points.
- cangjie_ark_interop: Depends on APILevel class definitions and BusinessException class definitions for API annotation and throwing exceptions to users in error branches.

## Directory Structure

```
test/testfwk/testfwk_cangjie_wrapper
├── figures         # architecture pictures
├── kit             # Cangjie test framework kit code
│   └── TestKit     # Test framework kit module
└── ohos            # Cangjie test framework interface implementation
│   └── ui_test     # UI test framework implementation
└── test            # Cangjie test framework test cases
    └── uitest  # UI test framework test cases
```

## Usage

The testfwk_testfwk_cangjie_wrapper currently provides the following functions:

- UiTest.

For UI test related APIs, please refer to [ohos.ui_test (UI Testing)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/TestKit/cj-apis-ui_test.md). For related guidelines, please refer to [Automated Test Framework Usage Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/application-test/cj-arkxtest-guidelines.md).

## Constraints

Compared to ArkTs API, there are the following differences:

- The unit test framework is implemented based on the unit test library [std.unittest](https://gitcode.com/Cangjie/cangjie_runtime/blob/main/README_zh.md) that comes with Cangjie.
- White-box performance test framework is not currently supported.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[startup_init](https://gitcode.com/openharmony/startup_init)

[testfwk_arkxtest](https://gitcode.com/openharmony/testfwk_arkxtest)