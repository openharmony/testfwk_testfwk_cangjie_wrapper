# testfwk_testfwk_cangjie_wrapper(beta feature)

## Introduction

The testfwk_testfwk_cangjie_wrapper is a UI test framework (UiTest) provided for developers using the Cangjie language for application development on OpenHarmony. The currently open testfwk_testfwk_cangjie_wrapper only supports standard devices.

## System Architecture

**Figure 1** testfwk_cangjie_wrapper architecture

![testfwk_cangjie_wrapper architecture](figures/testfwk_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram, the testfwk_testfwk_cangjie_wrapper provides UI test framework functions:

Interface Layer:

- UiTest:  Provides developers with the capability to find and operate UI components, supporting the development of automated test scripts based on UI interactions.
  - Driver: As the core entry point, Driver provides comprehensive test environment management capabilities. It supports basic functions such as component finding, assertion, and waiting, and also provides rich interaction interfaces, including key operations, touch screen operations, mouse operations, gesture operations, screen capture, window management, and auxiliary testing functions. Driver is responsible for coordinating and managing the entire test process, serving as the central hub for executing various UI operations.
  - On: Provides developers with rich component characteristic description interfaces, supporting precise targeting of components through multiple attributes such as text, ID, and type. On supports not only single attribute matching but also multi-attribute combination matching and relative positioning based on other components, enabling more flexible and precise component location strategies.
  - Component: Represents a specific component object on the UI, found and returned through the Driver.findComponent(on: On) method. Unlike Driver's global control role, Component focuses on operations and attribute access for individual components. It provides developers with fine-grained operational capabilities for specific components, such as getting component attributes (text, ID, type, etc.), clicking components, double-clicking, long-pressing, dragging to target positions, text injection, scrolling search, and pinch zooming.
  - UiWindow: Represents a window object on the UI, found through the Driver.findWindow(filter: WindowFilter) method, where WindowFilter can set attributes such as the title and ID of the window to be found. The window object provides developers with interfaces to get window attributes (such as boundaries, package name, title, etc.) and perform window operations such as window dragging, resizing, maximizing, minimizing, and closing windows.

Framework Layer:

- UiTest Wrapper: Implements the UiTest wrapper based on the underlying arkxtest's UI test basic capabilities, providing a complete UI test framework through Driver class, On class, Component class, and UiWindow class.

Dependency Components Introduction in Architecture:

- arkxtest: UiTest Wrapper depends on the UI testing capabilities provided by the arkxtest.
- init: UiTest Wrapper depends on the system parameter query capability provided by the init. The system determines whether to allow the execution of UI test operations by querying specific parameters (such as persist.ace.testmode.enabled). This ensures that UiTest runs only in an appropriate environment and avoids interfering with normal user operations. Users can enable or disable the test mode by setting system parameters; for example, enable the test mode through the hdc command 'hdc shell param set persist.ace.testmode.enabled 1'.
- ability_cangjie_wrapper: UiTest Wrapper depends on the AbilityDelegatorRegistry for initializing the UI testing framework.
- hiviewdfx_cangjie_wrapper: UiTest Wrapper depends on HiLog capabilities for printing logs at key points.
- cangjie_ark_interop: UiTest Wrapper depends on APILevel class definitions and BusinessException class definitions for API annotation and throwing exceptions to users in error branches.

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