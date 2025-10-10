# 测试框架仓颉封装（beta特性）

## 简介

测试框架仓颉封装是在OpenHarmony上面向开发者使用仓颉语言进行应用开发时提供的一套UI测试框架（UiTest）。当前开放的测试框架仓颉封装仅支持standard设备。

## 系统架构

**图 1**  测试框架仓颉架构图

![测试框架仓颉架构图](figures/testfwk_cangjie_wrapper_architecture_zh.png)

如架构图所示：

- UI测试框架接口：面向开发者提供查找和操作界面控件的能力，支持用户开发基于界面操作的自动化测试脚本。
  - Driver: 作为UI测试的核心入口，Driver提供全面的测试环境管理能力。它支持控件查找、断言、等待等基本功能，还提供丰富的交互接口，包括按键操作、触屏操作、鼠标操作、屏幕截图、窗口管理以及辅助测试功能。Driver负责整个测试流程的协调和管理，是执行各种UI操作的中枢。
  - On: 面向开发者提供丰富的控件特征描述接口，支持通过文本、id、类型等多种属性来精确定位目标控件。On不仅支持单一属性匹配，还支持多属性组合匹配，以及基于其他控件的相对定位方式，从而实现更加灵活和精确的控件定位策略。
  - Component: 表示UI界面上的一个具体控件对象，通过Driver.findComponent(on: On)方法进行查找并返回第一个匹配到的控件。与Driver的全局控制角色不同，Component专注于对单个控件的操作和属性访问。它为开发者提供获取控件属性（如文本、ID、类型等）、点击控件、双击、长按、拖拽至目标位置、文本注入、滑动查找、捏合缩放等针对特定控件的精细化操作能力。
  - UiWindow: 表示UI界面上的一个窗口对象，通过Driver.findWindow(filter: WindowFilter)方法进行查找并返回第一个匹配到的窗口，其中WindowFilter可以设置待查找窗口的标题以及id等属性。窗口对象面向开发者提供获取窗口属性（如边界、包名、标题等），进行窗口拖动、调整窗口大小、最大化、最小化以及关闭窗口等接口能力。

框架层：

- UI测试框架封装：基于底层自动化测试框架的UI测试基础能力实现UI测试框架封装，通过Driver类、On类、Component类以及UiWindow类提供一套完整的UI测试框架。

架构图中依赖部件引入说明：

- 自动化测试框架：UI测试框架封装的实现依赖自动化测试框架部件提供的UI测试基础能力。
- init组件：UI测试框架封装依赖init组件提供的系统参数查询能力，系统通过查询特定参数（如测试模式是否启用）来确定是否允许执行UI测试操作，这确保了测试框架只在合适的环境中运行，避免对正常操作造成干扰。开发者可以通过设置系统参数来启用或禁用测试模式，例如通过hdc命令`hdc shell param set persist.ace.testmode.enabled 1`启用测试模式。
- ability_cangjie_wrapper：UI测试框架封装依赖ability_cangjie_wrapper提供的自动化测试框架管理能力，用于框架的初始化。
- hiviewdfx_cangjie_wrapper：UI测试框架封装依赖hiviewdfx_cangjie_wrapper提供的HiLog日志能力，用于在关键路径打印日志。
- cangjie_ark_interop：UI测试框架封装依赖cangjie_ark_interop提供的仓颉注解类定义和BusinessException异常类定义，用于对API进行标注，及在错误分支向用户抛出异常。

## 目录

```
test/testfwk/testfwk_cangjie_wrapper
├── figures         # 存放README架构图
├── kit             # 仓颉测试框架kit化代码
│   └── TestKit     # 测试框架kit模块
└── ohos            # 仓颉测试框架接口实现
│   └── ui_test     # UI测试框架实现
└── test            # 测试用例
    └── uitest  # UI测试框架测试用例
```

## 使用说明

当前测试框架仓颉封装提供了以下功能：

- UI测试框架。

UI测试相关的接口请参见[UI测试API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/TestKit/cj-apis-ui_test.md)，相关开发指导请参见[自动化测试框架使用指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/application-test/cj-arkxtest-guidelines.md)。

## 约束

与ArkTS提供的API能力相比，有以下差异：

- 暂不支持白盒性能测试框架。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[startup_init](https://gitcode.com/openharmony/startup_init)

[testfwk_arkxtest](https://gitcode.com/openharmony/testfwk_arkxtest)
