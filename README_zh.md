# 测试框架仓颉接口

## 简介

 测试框架仓颉接口是在OpenHarmony上基于测试子系统能力之上封装的仓颉API。测试子系统是OpenHarmony为开发者提供了一套自动化测试框架，测试框架仓颉接口主要由单元测试框架以及UI测试框架构成。当前开放的测试框架仓颉接口仅支持standard设备。

## 系统架构

**图 1**  测试框架仓颉架构图

![测试框架仓颉架构图](figures/testfwk_cangjie_wrapper_architecture_zh.png)

如架构图所示，测试框架仓颉接口提供了UI测试框架功能：

- Driver是UI测试的入口，提供查找控件、检查控件存在性以及注入按键能力。
- On是用于描述目标控件特征（文本、id、类型等），Driver根据On描述的控件特征来查找控件。
- Component是Driver查找返回的控件对象，提供查询控件属性，滑动查找等触控和检视能力。
- UiWindow是Driver查找返回的窗口对象，提供获取窗口属性、操作窗口的能力。
- 仓颉测试框架FFI接口定义： 负责定义C互操作仓颉接口，用于实现仓颉测试框架能力。
- 自动化测试框架：负责提供UI测试基础能力，封装C接口提供给仓颉进行互操作。

## 目录

```
test/testfwk/testfwk_cangjie_wrapper
├── figures         # 存放README架构图
├── kit             # 仓颉测试框架kit化代码
│   └── TestKit
└── ohos            # 仓颉测试框架接口实现
│   └── ui_test
└── test            # 仓颉测试框架测试用例
```

## 使用说明

当前测试框架仓颉接口提供了以下功能：

- 编写测试用例、断言、执行测试用例以及生成测试报告的能力。
- 定位和操作UI组件的能力。

与ArkTs相比，有以下差异：

- 单元测试框架基于仓颉语言自带的单元测试库std.unittest实现。

UI测试相关的API请参见[ohos.ui_test（UI测试）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/TestKit/cj-apis-ui_test.md)，相关指导请参见[自动化测试框架使用指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/application-test/cj-arkxtest-guidelines.md)。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[自动化测试框架](https://gitee.com/openharmony/testfwk_arkxtest/blob/master/README_zh.md)

[仓颉ArkUI开发框架](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)
