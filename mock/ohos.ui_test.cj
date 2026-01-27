/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

package ohos.ui_test

import ohos.callback_invoke.Callback
import ohos.labels.APILevel

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class Driver {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public static func create(): Driver {
        return Driver()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func delayMs(duration: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func findComponent(on: On): ?Component {
        return None
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func findWindow(filter: WindowFilter): ?UiWindow {
        return None
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func waitForComponent(on: On, time: Int32): ?Component {
        return None
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func findComponents(on: On): ?Array<Component> {
        return None
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func assertComponentExist(on: On): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        workerthread: true
    ]
    public func pressBack(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func triggerKey(keyCode: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func triggerCombineKeys(key0: Int32, key1: Int32, key2!: Int32 = 0): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func click(x: Int32, y: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func doubleClick(x: Int32, y: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func longClick(x: Int32, y: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func swipe(
        startx: Int32,
        starty: Int32,
        endx: Int32,
        endy: Int32,
        speed!: Int32 = 600
    ): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func drag(
        startx: Int32,
        starty: Int32,
        endx: Int32,
        endy: Int32,
        speed!: Int32 = 600
    ): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func screenCap(savePath: String): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func setDisplayRotation(rotation: DisplayRotation): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        workerthread: true
    ]
    public func getDisplayRotation(): DisplayRotation {
        return DisplayRotation.Rotation0
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func setDisplayRotationEnabled(enabled: Bool): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        workerthread: true
    ]
    public func getDisplaySize(): Point {
        return Point(
            0,
            0,
            displayId: None
        )
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        workerthread: true
    ]
    public func getDisplayDensity(): Point {
        return Point(
            0,
            0,
            displayId: None
        )
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        workerthread: true
    ]
    public func wakeUpDisplay(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        workerthread: true
    ]
    public func pressHome(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func waitForIdle(idleTime: Int32, timeout: Int32): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func fling(from: Point, to: Point, stepLen: Int32, speed: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func injectMultiPointerAction(pointers: PointerMatrix, speed!: Int32 = 600): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func fling(direction: UiDirection, speed: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseClick(p: Point, btnId: MouseButton, key1!: Int32 = 0, key2!: Int32 = 0): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseMoveTo(p: Point): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseScroll(p: Point, down: Bool, d: Int32, key1!: Int32 = 0, key2!: Int32 = 0, speed!: Int32 = 20): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func screenCapture(savePath: String, rect!: Rect = Rect(0, 0, 0, 0)): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func createUiEventObserver(): UiEventObserver {
        return UiEventObserver()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseDoubleClick(p: Point, btnId: MouseButton, key1!: Int32 = 0, key2!: Int32 = 0): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseLongClick(p: Point, btnId: MouseButton, key1!: Int32 = 0, key2!: Int32 = 0): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseMoveWithTrack(from: Point, to: Point, speed!: Int32 = 600): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func mouseDrag(from: Point, to: Point, speed!: Int32 = 600): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func inputText(p: Point, text: String): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class PointerMatrix {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public static func create(fingers: Int32, steps: Int32): PointerMatrix {
        return PointerMatrix()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func setPoint(finger: Int32, step: Int32, point: Point): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class UiWindow {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getBundleName(): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getBounds(): Rect {
        return Rect(
            0,
            0,
            0,
            0,
            displayId: None
        )
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getTitle(): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getWindowMode(): WindowMode {
        return WindowMode.Fullscreen
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isFocused(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func focus(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func moveTo(x: Int32, y: Int32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func resize(wide: Int32, height: Int32, direction: ResizeDirection): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func split(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func maximize(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func minimize(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func resume(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func close(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isActive(): Bool {
        return true
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class On {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init() {
        super()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func text(txt: String, pattern!: MatchPattern = MatchPattern.Equals): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func id(id: String): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func onType(tp: String): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func clickable(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func longClickable(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func scrollable(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func enabled(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func focused(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func selected(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func checked(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func checkable(b!: Bool = true): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func isBefore(on: On): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func isAfter(on: On): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func within(on: On): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func inWindow(bundleName: String): On {
        return On()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func description(val: String, pattern!: MatchPattern = MatchPattern.Equals): On {
        return On()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum OnceType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    ToastShow
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    DialogShow
    | ...
}

extend OnceType <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func toString(): String {
        return String()
    }
}

extend OnceType <: Equatable<OnceType> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public operator func ==(other: OnceType): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public operator func !=(other: OnceType): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class UiEventObserver {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true
    ]
    public func once(onceType: OnceType, callback: Callback<UiElementInfo>): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class Component {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func click(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func doubleClick(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func longClick(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getId(): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getText(): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getType(): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isClickable(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isLongClickable(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isScrollable(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isEnabled(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isFocused(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isSelected(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isChecked(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func isCheckable(): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func inputText(text: String): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func clearText(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func scrollToTop(speed!: Int64 = 600): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func scrollToBottom(speed!: Int64 = 600): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getBounds(): Rect {
        return Rect(
            0,
            0,
            0,
            0,
            displayId: None
        )
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func scrollSearch(on: On): ?Component {
        return None
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getBoundsCenter(): Point {
        return Point(
            0,
            0,
            displayId: None
        )
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func dragTo(target: Component): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func pinchOut(scale: Float32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func pinchIn(scale: Float32): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest",
        throwexception: true,
        workerthread: true
    ]
    public func getDescription(): String {
        return String()
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum MatchPattern {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Equals
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Contains
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    StartsWith
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    EndsWith
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum DisplayRotation {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation0
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation90
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation180
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation270
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum WindowMode {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Fullscreen
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Primary
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Secondary
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Floating
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum ResizeDirection {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Left
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Right
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Up
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Down
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    LeftUp
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    LeftDown
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    RightUp
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    RightDown
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum UiDirection {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Left
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Right
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Up
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Down
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum MouseButton {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonLeft
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonRight
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonMiddle
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class Point {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var x: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var y: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(x: Int32, y: Int32, displayId!: ?Int32 = None) {
        super()
        this.x = 0
        this.y = 0
        this.displayId = None
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class UiElementInfo {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let bundleName: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let componentType: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let text: String
    
    public init() {
        super()
        this.bundleName = String()
        this.componentType = String()
        this.text = String()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class WindowFilter {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var bundleName: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var title: ?String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var focused: ?Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var active: ?Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(bundleName!: ?String = None, title!: ?String = None, focused!: ?Bool = None, active!: ?Bool = None,
        displayId!: ?Int32 = None) {
        super()
        this.bundleName = None
        this.title = None
        this.focused = None
        this.active = None
        this.displayId = None
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class Rect {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var left: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var top: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var right: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var bottom: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(left: Int32, top: Int32, right: Int32, bottom: Int32, displayId!: ?Int32 = None) {
        super()
        this.left = 0
        this.top = 0
        this.right = 0
        this.bottom = 0
        this.displayId = None
    }
}
