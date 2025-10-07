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

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.ui_test

import ohos.labels.*
import ohos.ffi.*
import std.convert.Parsable
import ohos.encoding.json.*
import std.convert.*

/**
 * Enumerates the string value match pattern.
 *
 * @relation declare enum MatchPattern
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum MatchPattern {
    /**
     * Equals to a string.
     * 
     * @relation EQUALS = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Equals
    |
    /**
     * Contains a substring.
     * 
     * @relation CONTAINS = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Contains
    |
    /**
     * StartsWith a substring.
     * 
     * @relation STARTS_WITH = 2
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    StartsWith
    |
    /**
     * EndsWith a substring.
     * 
     * @relation ENDS_WITH = 3
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    EndsWith
    | ...

    func getValue(): Int32 {
        match (this) {
            case Equals => 0
            case Contains => 1
            case StartsWith => 2
            case EndsWith => 3
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates the rotation of the device display.
 *
 * @relation declare enum DisplayRotation
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum DisplayRotation {
    /**
     * Device display does not rotate to display vertically.
     * 
     * @relation ROTATION_0 = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation0
    |
    /**
     * Device display rotates 90 degrees clockwise to display horizontally.
     * 
     * @relation ROTATION_90 = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation90
    |
    /**
     * Device display rotates clockwise 180 degrees to display vertically in reverse.
     * 
     * @relation ROTATION_180 = 2
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation180
    |
    /**
     * Device display rotates 270 degrees clockwise to display horizontally in reverse.
     * 
     * @relation ROTATION_270 = 3
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation270
    | ...

    func getValue(): Int32 {
        match (this) {
            case Rotation0 => 0
            case Rotation90 => 1
            case Rotation180 => 2
            case Rotation270 => 3
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: String): DisplayRotation {
        match (val) {
            case "0" => Rotation0
            case "1" => Rotation90
            case "2" => Rotation180
            case "3" => Rotation270
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates the window mode of the tested window.
 *
 * @relation declare enum WindowMode
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum WindowMode {
    /**
     * The test window is a full screen window.
     * 
     * @relation FULLSCREEN = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Fullscreen
    |
    /**
     * The test window is the first window in the split screen state.
     * 
     * @relation PRIMARY = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Primary
    |
    /**
     * The test window is the second window in the split screen state.
     * 
     * @relation SECONDARY = 2
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Secondary
    |
    /**
     * The test window is a floating window.
     * 
     * @relation FLOATING = 3
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Floating
    | ...

    func getValue(): Int32 {
        match (this) {
            case Fullscreen => 0
            case Primary => 1
            case Secondary => 2
            case Floating => 3
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: String) {
        match (val) {
            case "0" => Fullscreen
            case "1" => Primary
            case "2" => Secondary
            case "3" => Floating
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates the resize direction for the window.
 *
 * @relation declare enum ResizeDirection
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum ResizeDirection {
    /**
     * Left.
     * 
     * @relation LEFT = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Left
    |
    /**
     * Right.
     * 
     * @relation RIGHT = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Right
    |
    /**
     * Up.
     * 
     * @relation UP = 2
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Up
    |
    /**
     * Down.
     * 
     * @relation DOWN = 3
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Down
    |
    /**
     * Upper left.
     * 
     * @relation LEFT_UP = 4
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    LeftUp
    |
    /**
     * Lower left.
     * 
     * @relation LEFT_DOWN = 5
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    LeftDown
    |
    /**
     * Upper right.
     * 
     * @relation RIGHT_UP = 6
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    RightUp
    |
    /**
     * Lower right.
     * 
     * @relation RIGHT_DOWN = 7
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    RightDown
    | ...

    func getValue(): Int32 {
        match (this) {
            case Left => 0
            case Right => 1
            case Up => 2
            case Down => 3
            case LeftUp => 4
            case LeftDown => 5
            case RightUp => 6
            case RightDown => 7
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates the direction for the UI operation .
 *
 * @relation declare enum UiDirection
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum UiDirection {
    /**
     * Left.
     * 
     * @relation LEFT = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Left
    |
    /**
     * Right.
     * 
     * @relation RIGHT = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Right
    |
    /**
     * Up.
     * 
     * @relation UP = 2
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Up
    |
    /**
     * Down.
     * 
     * @relation DOWN = 3
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    Down
    | ...

    func getValue(): Int32 {
        match (this) {
            case Left => 0
            case Right => 1
            case Up => 2
            case Down => 3
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Enumerates the id of the button on the mouse.
 *
 * @relation declare enum MouseButton
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum MouseButton {
    /**
     * Left button of the mouse.
     * 
     * @relation MOUSE_BUTTON_LEFT = 0
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonLeft
    |
    /**
     * Right button of the mouse.
     * 
     * @relation MOUSE_BUTTON_RIGHT = 1
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonRight
    |
    /**
     * Middle button of the mouse.
     * 
     * @relation MOUSE_BUTTON_MIDDLE = 2
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonMiddle
    | ...

    func getValue(): Int32 {
        match (this) {
            case MouseButtonLeft => 0
            case MouseButtonRight => 1
            case MouseButtonMiddle => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Represents the point on the device screen.
 *
 * @relation declare interface Point
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class Point {
    /**
    * The x-coordinate of the coordinate point.
    *
    * @relation x: number
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var x: Int32

    /**
    * The y-coordinate of the coordinate point.
    *
    * @relation y: number
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var y: Int32

    /**
    * The displayId to which the coordinate point belongs, default is the displayId of the main scrren.
    *
    * @relation displayId?: number
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32    

    /**
     * Point constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(x: Int32, y: Int32, displayId!: ?Int32 = None) {
        if (!displayId.isNone()) {
            throw IllegalArgumentException("Invalid argument.")
        }
        this.x = x
        this.y = y
        this.displayId = displayId
    }

    init(jsonStr: String) {
        let jsonObj = JsonValue.fromStr(jsonStr).asObject()
        this.x = getNumberFromJsonObject(jsonObj, "x")
        this.y = getNumberFromJsonObject(jsonObj, "y")
        if (let Some(num) <- jsonObj.get("displayId")) {
            this.displayId = Int32(num.asInt().getValue())
        } else {
            this.displayId = Option<Int32>.None
        }
    }
}

/**
 * Represents the information of an UI element, can be a component or window.
 *
 * @relation declare interface UIElementInfo
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class UIElementInfo {
    /**
    * The bundle name of the host application.
    *
    * @relation readonly bundleName: string
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let bundleName: String

    /**
    * The component type, set it as 'window' if it's a window.
    *
    * @relation readonly type: string
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let componentType: String

    /**
    * The text of component, set it as window's title if it's a window.
    *
    * @relation readonly text: string
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let text: String

    init(cInfo: CUIElementInfo) {
        this.bundleName = cInfo.bundleName.toString()
        this.componentType = cInfo.componentType.toString()
        this.text = cInfo.text.toString()
    }
}

/**
 * Represents filer condition to get the window.
 *
 * @relation declare interface WindowFilter
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class WindowFilter {
    /**
     * The package name of the application which the window belongs to.
     * 
     * @relation bundleName?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var bundleName: ?String

    /**
     * The title of the window.
     * 
     * @relation title?: string
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var title: ?String

    /**
     * The focal state of the window.
     * 
     * @relation focused?: boolean
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var focused: ?Bool

    /**
     * The active state of the window.
     * 
     * @relation actived?: boolean
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var active: ?Bool

    /**
     * Find the window in the specified ID display. By default, it searches all displays.
     * 
     * @relation displayId?: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    /**
     * WindowFilter constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(bundleName!: ?String = None, title!: ?String = None, focused!: ?Bool = None, active!: ?Bool = None, displayId!: ?Int32 = None) {
        if (!displayId.isNone()) {
            throw IllegalArgumentException("Invalid argument.")
        }
        this.bundleName = bundleName
        this.title = title
        this.focused = focused
        this.active = active
        this.displayId = displayId
    }
}

/**
 * Represents the rectangle area on the device screen.
 *
 * @relation declare interface Rect
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class Rect {
    /**
     * The x-coordinate of the top left corner of the rectangle.
     * 
     * @relation left: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var left: Int32

    /**
     * The y-coordinate of the top left corner of the rectangle.
     * 
     * @relation top: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var top: Int32

    /**
     * The x-coordinate at the bottom right corner of the rectangle.
     * 
     * @relation right: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var right: Int32

    /**
     * The y-coordinate at the bottom right corner of the rectangle.
     * 
     * @relation bottom: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var bottom: Int32

    /**
     * The displayId to which the rect belongs, default is the displayId of the main screen.
     * 
     * @relation displayId?: number
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    /**
     * Rect constructor.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(left: Int32, top: Int32, right: Int32, bottom: Int32, displayId!: ?Int32 = None) {
        if (!displayId.isNone()) {
            throw IllegalArgumentException("Invalid argument.")
        }
        this.left = left
        this.top = top
        this.right = right
        this.bottom = bottom
        this.displayId = displayId
    }

    init(jsonStr: String) {
        let jsonObj = JsonValue.fromStr(jsonStr).asObject()
        this.left = getNumberFromJsonObject(jsonObj, "left")
        this.right = getNumberFromJsonObject(jsonObj, "right")
        this.top = getNumberFromJsonObject(jsonObj, "top")
        this.bottom = getNumberFromJsonObject(jsonObj, "bottom")
        if (let Some(num) <- jsonObj.get("displayId")) {
            this.displayId = Int32(num.asInt().getValue())
        } else {
            this.displayId = Option<Int32>.None
        }
    }
}

func getNumberFromJsonObject(jsonObj: JsonObject, key: String): Int32 {
    if (let Some(num) <- jsonObj.get(key)) {
        Int32(num.asInt().getValue())
    } else {
        throw Exception("getNumberFromJsonObject failed")
    }
}
