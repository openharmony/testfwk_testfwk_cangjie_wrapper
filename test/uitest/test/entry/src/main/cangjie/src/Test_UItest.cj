/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos_app_cangjie_entry

internal import std.sync.*
import std.unittest.testmacro.*
import kit.TestKit.*
import kit.TestKit.{Rect as Rct, MouseButton as MouseBtn, Point as PT}
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import kit.PerformanceAnalysisKit.Hilog
import ohos.business_exception.*


@Test
public class Test_UItest {
    private var _driver: ?Driver = None
    private prop driver: Driver {
        get() {
            match (_driver) {
                case Some(driver) => driver
                case None =>
                    let newDriver = Driver.create()
                    _driver = newDriver
                    newDriver
            }
        }
    }
    override func afterAll(): Unit {
        gc(heavy: true)
        sleep(Duration.second)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_get_value() {
//        let uiTest = UITest()
//        UITest.setup()
        let on1 = On().text("111", pattern: MatchPattern.Contains)
        let on2 = On().text("111", pattern: MatchPattern.StartsWith)
        let on3 = On().text("111", pattern: MatchPattern.EndsWith)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testOn() {
        let on1 = On()
            .text("111")
            .clickable()
            .longClickable()
            .scrollable()
            .enabled()
            .focused()
            .selected()
            .checked()
            .onType("Button")
            .checkable()
            .inWindow("555")
            .id("id")
            .description("444", pattern: MatchPattern.Equals)
        let on2 = On().isBefore(on1).isAfter(on1).within(on1)
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testUIObserver() {
        let observer: UIEventObserver = driver.createUIEventObserver()
        let callbackTrigger = AtomicBool(false)
        observer.once(
            OnceType.ToastShow,
            {
                element =>
                Hilog.info(0, "", element.bundleName)
                Hilog.info(0, "", element.componentType)
                Hilog.info(0, "", element.text)
            }
        )
        observer.once(
            OnceType.DialogShow,
            {
                element =>
                Hilog.info(0, "", "onceDialogShow")
                Hilog.info(0, "", element.bundleName)
                Hilog.info(0, "", element.componentType)
                Hilog.info(0, "", element.text)
                callbackTrigger.compareAndSwap(false, true)
                @Expect(true)
            }
        )

        driver.delayMs(3000)
        let button = driver.findComponent(On().id("id")).getOrThrow()
        button.click()
        driver.delayMs(3000)
        @Expect(callbackTrigger.load())
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testPointerMatrix() {
        getPointerMatrix()
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testComponent() {
        let button = driver.findComponent(On().id("id")).getOrThrow()

        driver.assertComponentExist(On().onType("Button"))

        let scrollBar = driver.findComponent(On().onType("Scroll")).getOrThrow()
        let button2 = scrollBar.scrollSearch(On().text("1"))
        scrollBar.scrollToBottom()
        scrollBar.scrollToTop()

        let textComponent: Component = driver.findComponent(On().onType("TextInput")).getOrThrow()
        let point = textComponent.getBoundsCenter()
        driver.inputText(point, "123")
        button.click()
        button.doubleClick()
        button.longClick()
        let id = button.getId()
        let text = button.getText()
        let btype = button.getType()
        let rect = button.getBounds()
        let p = button.getBoundsCenter()
        let c = button.isClickable()
        let c1 = button.isLongClickable()
        let c2 = button.isChecked()
        let c3 = button.isCheckable()
        let s = button.isScrollable()
        let e = button.isEnabled()
        let f = button.isFocused()
        let s1 = button.isSelected()
        let des = button.getDescription()

        let txt = driver.findComponent(On().text("cangjie")).getOrThrow()
        txt.clearText()
        // txt.inputText("111")

        let drag = driver.findComponent(On().text("ohos")).getOrThrow()
        button.dragTo(drag)
        let buttons = driver.findComponents(On().onType("Button")).getOrThrow()
        let button1 = driver.waitForComponent(On().onType("Button"), 100).getOrThrow()

        let image = driver.findComponent(On().id("icon")).getOrThrow()
        image.pinchIn(0.5)
        image.pinchOut(2.5)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testDriver() {
        driver.wakeUpDisplay()

        driver.getDisplaySize()
        driver.getDisplayDensity()

        driver.setDisplayRotationEnabled(true)
        driver.setDisplayRotation(DisplayRotation.Rotation0)
        let rotation0 = driver.getDisplayRotation()
        driver.setDisplayRotation(DisplayRotation.Rotation90)
        let rotation90 = driver.getDisplayRotation()
        driver.setDisplayRotation(DisplayRotation.Rotation270)
        let rotation270 = driver.getDisplayRotation()
        driver.setDisplayRotation(DisplayRotation.Rotation180)
        let rotation = driver.getDisplayRotation()
        driver.click(100, 100)
        driver.doubleClick(100, 100)
        driver.screenCap("/data/storage/el2/base/cache/1.png")
        driver.longClick(100, 100)
        driver.waitForIdle(100, 100)

        driver.injectMultiPointerAction(getPointerMatrix())
        driver.screenCapture("/data/storage/el2/base/cache/1.png", rect: Rct(0, 0, 100, 100))

        driver.fling(PT(500, 480), PT(450, 480), 5, 600)
        driver.fling(UiDirection.Down, 10000)
        driver.fling(UiDirection.Up, 10000)
        driver.fling(UiDirection.Left, 10000)
        driver.fling(UiDirection.Right, 10000)
        driver.fling(UiDirection.Down, 10000)
        driver.swipe(100, 100, 200, 200, speed: 600)
        driver.drag(100, 100, 200, 200, speed: 600)
        driver.pressHome()
        driver.pressBack()

        driver.mouseClick(PT(248, 194), MouseBtn.MouseButtonLeft, key1: 2072)
        try {
            driver.mouseClick(PT(248, 194), MouseBtn.MouseButtonLeft, key1: 2072, key2: 2035)
            // logger.info("mouseClick with key2 success")
        } catch (e: BusinessException) {
            // logger.info("mouseClick error : ${e}")
        }
        driver.mouseMoveTo(PT(248, 194))
        driver.mouseScroll(PT(360, 640), true, 30, key1: 2072)
        try {
            driver.mouseScroll(PT(360, 640), true, 30, key1: 2072, key2: 2035)
            // logger.info("mouseScroll with key2 success")
        } catch (e: BusinessException) {
            // logger.info("mouseClick error : ${e}")
        }
        driver.mouseDoubleClick(PT(248, 194), MouseBtn.MouseButtonRight, key1: 2072)
        driver.mouseLongClick(PT(248, 194), MouseBtn.MouseButtonMiddle, key1: 2072)
        driver.mouseMoveWithTrack(PT(100, 100), PT(200, 200))
        driver.mouseDrag(PT(100, 100), PT(200, 200))
        driver.triggerKey(1)
        driver.triggerCombineKeys(2072, 2047, key2: 2035)
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testUIWindow() {
        let window = driver.findWindow(WindowFilter(active: true)).getOrThrow()
        let name = window.getBundleName()
        // logger.info(name)
        @Expect(!name.isEmpty() && !name.startsWith("\""))
        let rect = window.getBounds()
        let title: String = window.getTitle()
        // logger.info(title)
        @Expect(title.isEmpty())
        let mode = window.getWindowMode()
        //        let focused = window.isFocused()
        //        let active = window.isActive()
        window.focus()
        @Expect(window.isFocused())
        @Expect(window.isActive())
        // not support
        try {
            window.moveTo(100, 100)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.Right)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.Up)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.Down)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.LeftUp)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.RightDown)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.LeftDown)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.RightUp)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resize(100, 100, ResizeDirection.Left)
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.split()
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.maximize()
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.minimize()
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.resume()
        } catch (e: Exception) {
            // logger.info("${e}")
        }
        try {
            window.close()
        } catch (e: Exception) {
            // logger.info("${e}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func addLLT(): Unit {
        let wf = WindowFilter(bundleName: "test", title: "test", focused: true, active: true)
        try {
            driver.findWindow(wf)
            ()
        } catch (e: Exception) {
            // logger.error(e.message)
        }
    }
}

func getPointerMatrix() {
    let pointers = PointerMatrix.create(2, 3)
    pointers.setPoint(0, 0, PT(230, 480))
    pointers.setPoint(0, 1, PT(250, 380))
    pointers.setPoint(0, 2, PT(270, 280))
    pointers.setPoint(1, 0, PT(230, 680))
    pointers.setPoint(1, 1, PT(240, 580))
    pointers.setPoint(1, 2, PT(250, 480))
    pointers
}
