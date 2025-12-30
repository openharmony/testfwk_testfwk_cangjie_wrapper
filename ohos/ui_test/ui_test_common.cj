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

import ohos.labels.{APILevel, Hide}
import ohos.encoding.json.{JsonObject, JsonValue}
import ohos.business_exception.BusinessException

/**
 * Enumerates the string value match pattern.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum MatchPattern {
    /**
     * Equals to a string.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Equals
    |
    /**
     * Contains a substring.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Contains
    |
    /**
     * StartsWith a substring.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    StartsWith
    |
    /**
     * EndsWith a substring.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    EndsWith
    |
    @!Hide[isChecked: true]
    RegExp
    |
    @!Hide[isChecked: true]
    RegExpIcase
    | ...

    func getValue(): Int32 {
        match (this) {
            case Equals => 0
            case Contains => 1
            case StartsWith => 2
            case EndsWith => 3
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }
}

/**
 * Enumerates the rotation of the device display.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum DisplayRotation {
    /**
     * Device display does not rotate to display vertically.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation0
    |
    /**
     * Device display rotates 90 degrees clockwise to display horizontally.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation90
    |
    /**
     * Device display rotates clockwise 180 degrees to display vertically in reverse.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Rotation180
    |
    /**
     * Device display rotates 270 degrees clockwise to display horizontally in reverse.
     */
    @!APILevel[
        since: "22",
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
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }

    /*
     * @throws { BusinessException } 14700104 - The type is not supported.
     */
    static func parse(val: String): DisplayRotation {
        match (val) {
            case "0" => Rotation0
            case "1" => Rotation90
            case "2" => Rotation180
            case "3" => Rotation270
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }
}

/**
 * Enumerates the window mode of the tested window.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum WindowMode {
    /**
     * The test window is a full screen window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Fullscreen
    |
    /**
     * The test window is the first window in the split screen state.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Primary
    |
    /**
     * The test window is the second window in the split screen state.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Secondary
    |
    /**
     * The test window is a floating window.
     */
    @!APILevel[
        since: "22",
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
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }

    /*
     * @throws { BusinessException } 14700104 - The type is not supported.
     */
    static func parse(val: String) {
        match (val) {
            case "0" => Fullscreen
            case "1" => Primary
            case "2" => Secondary
            case "3" => Floating
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }
}

/**
 * Enumerates the resize direction for the window.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum ResizeDirection {
    /**
     * Left.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Left
    |
    /**
     * Right.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Right
    |
    /**
     * Up.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Up
    |
    /**
     * Down.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Down
    |
    /**
     * Upper left.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    LeftUp
    |
    /**
     * Lower left.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    LeftDown
    |
    /**
     * Upper right.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    RightUp
    |
    /**
     * Lower right.
     */
    @!APILevel[
        since: "22",
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
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }
}

/**
 * Enumerates the direction for the Ui operation .
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum UiDirection {
    /**
     * Left.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Left
    |
    /**
     * Right.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Right
    |
    /**
     * Up.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    Up
    |
    /**
     * Down.
     */
    @!APILevel[
        since: "22",
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
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }
}

/**
 * Enumerates the id of the button on the mouse.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public enum MouseButton {
    /**
     * Left button of the mouse.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonLeft
    |
    /**
     * Right button of the mouse.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonRight
    |
    /**
     * Middle button of the mouse.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    MouseButtonMiddle
    | ...

    func getValue(): Int32 {
        match (this) {
            case MouseButtonLeft => 0
            case MouseButtonRight => 1
            case MouseButtonMiddle => 2
            case _ => throw BusinessException(14700104, "The type is not supported.")
        }
    }
}

/**
 * Represents the point on the device screen.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class Point {
    /**
     * The x-coordinate of the coordinate point.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var x: Int32

    /**
     * The y-coordinate of the coordinate point.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var y: Int32

    /**
     * The displayId to which the coordinate point belongs, default is the displayId of the main scrren.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    /**
     * Point constructor.
     *
     * @param { Int32 } x - The x-coordinate of the coordinate point.
     * @param { Int32 } y - The y-coordinate of the coordinate point.
     * @param { ?Int32 } [displayId] - The displayId to which the coordinate point belongs, default is the displayId of the main scrren.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(x: Int32, y: Int32, displayId!: ?Int32 = None) {
        if (!displayId.isNone()) {
            throw BusinessException(14700102, "Invalid argument.")
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
 * Represents the information of an Ui element, can be a component or window.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class UiElementInfo {
    /**
    * The bundle name of the host application.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let bundleName: String

    /**
    * The component type, set it as 'window' if it's a window.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public let componentType: String

    /**
    * The text of component, set it as window's title if it's a window.
    */
    @!APILevel[
        since: "22",
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
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class WindowFilter {
    /**
     * The package name of the application which the window belongs to.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var bundleName: ?String

    /**
     * The title of the window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var title: ?String

    /**
     * The focal state of the window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var focused: ?Bool

    /**
     * The active state of the window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var active: ?Bool

    /**
     * Find the window in the specified ID display. By default, it searches all displays.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    /**
     * WindowFilter constructor.
     *
     * @param { ?String } [bundleName] - The package name of the application which the window belongs to.
     * @param { ?String } [title] - The title of the window.
     * @param { ?Bool } [focused] - The focal state of the window.
     * @param { ?Bool } [active] - The active state of the window.
     * @param { ?Int32 } [displayId] - The display ID. By default, it searches all displays.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(bundleName!: ?String = None, title!: ?String = None, focused!: ?Bool = None, active!: ?Bool = None, displayId!: ?Int32 = None) {
        if (!displayId.isNone()) {
            throw BusinessException(14700102, "Invalid argument.")
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
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Test.UiTest"
]
public class Rect {
    /**
     * The x-coordinate of the top left corner of the rectangle.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var left: Int32

    /**
     * The y-coordinate of the top left corner of the rectangle.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var top: Int32

    /**
     * The x-coordinate at the bottom right corner of the rectangle.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var right: Int32

    /**
     * The y-coordinate at the bottom right corner of the rectangle.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var bottom: Int32

    /**
     * The displayId to which the rect belongs, default is the displayId of the main screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public var displayId: ?Int32

    /**
     * Rect constructor.
     *
     * @param { Int32 } left - The x-coordinate of the top left corner of the rectangle.
     * @param { Int32 } top - The y-coordinate of the top left corner of the rectangle.
     * @param { Int32 } right - The x-coordinate at the bottom right corner of the rectangle.
     * @param { Int32 } bottom - The y-coordinate at the bottom right corner of the rectangle.
     * @param { ?Int32 } [displayId] - The displayId to which the rect belongs, default is the displayId of the main screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init(left: Int32, top: Int32, right: Int32, bottom: Int32, displayId!: ?Int32 = None) {
        if (!displayId.isNone()) {
            throw BusinessException(14700102, "Invalid argument.")
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

/*
 * @throws { BusinessException } 14700102 - Invalid argument.
 */
func getNumberFromJsonObject(jsonObj: JsonObject, key: String): Int32 {
    if (let Some(num) <- jsonObj.get(key)) {
        Int32(num.asInt().getValue())
    } else {
        throw BusinessException(14700102, "Invalid argument.")
    }
}
