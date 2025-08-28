# 测试框架仓颉接口

## 简介

 测试框架仓颉接口是在 OpenHarmony 上基于测试子系统能力之上封装的仓颉API。而测试子系统是OpenHarmony为开发者提供了一套自动化测试框架，其主要由单元测试以及UI测试框架构成。

 单元测试供相关API，可用于编写系统或应用程序接口的测试用例、执行单元测试用例以及生成测试报告。

 UI测试框架提供简单易用的API，可用于定位和操作UI组件，助力用户开发基于UI操作的自动化测试脚本。

## 系统架构

**图 1**  测试框架仓颉架构图

![测试框架仓颉架构图](figures/testfwk_cangjie_wrapper_architecture_zh.png "测试框架仓颉架构图")

## 目录

```cangjie
test/testfwk/testfwk_cangjie_wrapper
├── figures          # 存放readme架构图
├── kit              # 仓颉kit化代码
└── ohos             # 仓颉自动化测试框架接口实现
```

## 约束

当前开放的测试框架仓颉接口仅支持standard设备。

## 使用说明

如架构图所示，测试框架仓颉接口提供了UI测试框架功能，开发者可以根据使用诉求，综合使用一类或多类接口：

- Driver是UI测试的入口，提供查找控件、检查控件存在性以及注入按键能力。
- On是用于描述目标控件特征（文本、id、类型等），Driver根据On描述的控件特征来查找控件。
- Component是Driver查找返回的控件对象，提供查询控件属性，滑动查找等触控和检视能力。
- UiWindow是Driver查找返回的窗口对象，提供获取窗口属性、操作窗口的能力。

UI测试相关的API请参见[ohos.ui_test（UI测试）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/TestKit/cj-apis-ui_test.md)，相关指导请参见[自动化测试框架使用指导](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/Dev_Guide/source_zh_cn/application-test)。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[自动化测试框架](https://gitee.com/openharmony/testfwk_arkxtest/blob/master/README_zh.md)
