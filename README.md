# testfwk_testfwk_cangjie_wrapper

## Introduction

The testfwk_testfwk_cangjie_wrapper a suite of automated testing solutions tailored for developers engaged in application development with the Cangjie programming language on the OpenHarmony platform. It is primarily composed of two core components: a unit testing framework and a UI testing framework. The currently open testfwk_testfwk_cangjie_wrapper only supports standard devices.

## System Architecture

**Figure 1** testfwk_cangjie_wrapper architecture

![testfwk_cangjie_wrapper architecture](figures/testfwk_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram, the testfwk_testfwk_cangjie_wrapper provides UI test framework functions:

Interface Layer:

- Driver: The entry point for UI testing, providing developers with the ability to find controls, check their existence, and inject key presses.
- On: Provides developers with the ability to describe the characteristics of target controls. Developers can use these descriptions together with Driver to locate controls.
- Component: Represents a UI control, typically found using `Driver.findComponent(on)`. It offers developers the ability to query control properties, perform swipe-to-find operations, and other touch and inspection capabilities.
- UiWindow: Represents a UI window, typically found using `Driver.findWindow(WindowFilter)`. It provides developers with the ability to access window properties and manipulate windows.

Framework Layer:

- Driver Wrapper: Based on the underlying arkxtest's UI testing capabilities，Driver Wrapper implements features like finding controls, injecting key presses, clicking coordinates, swiping controls, performing gestures, and taking screenshots.
- On Wrapper: Based on the underlying arkxtest's UI testing capabilities, On Wrapper implements rich descriptions of target control characteristics (text, id, type, etc.) for matching and finding controls to operate on or inspect.
- Component Wrapper: Based on the underlying arkxtest's UI testing capabilities, Component Wrapper implements access to control properties, clicking controls, swipe-to-find operations, and text injection.
- UiWindow Wrapper: Based on the underlying arkxtest's UI testing capabilities, UiWindow implements access to window properties and window manipulation capabilities like dragging and resizing.

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

- Capabilities for writing test cases, assertions, executing test cases, and generating test reports.
- Capabilities for locating and operating UI components.

For UI test related APIs, please refer to [ohos.ui_test (UI Testing)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/TestKit/cj-apis-ui_test.md). For related guidelines, please refer to [Automated Test Framework Usage Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/application-test/cj-arkxtest-guidelines.md).

## Constraints

Compared to ArkTs API, there are the following differences:

- The unit test framework is implemented based on the unit test library std.unittest that comes with Cangjie.
- White-box performance testing framework is not currently supported.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[startup_init](https://gitcode.com/openharmony/startup_init)

[testfwk_arkxtest](https://gitcode.com/openharmony/testfwk_arkxtest)