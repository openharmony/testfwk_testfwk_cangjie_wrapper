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

package ohos.ui_test

import std.convert.Parsable
import ohos.encoding.json.*
import std.convert.*
import std.sync.*
import ohos.hilog.*
import ohos.app.ability.ability_delegator_registry.*
import ohos.app.ability.ui_ability.*
import ohos.labels.*
import ohos.ffi.*
import ohos.business_exception.*
import ohos.callback_invoke.*
import std.deriving.*

let SETUP_CALLED = AtomicBool(false)
let TEST_LOG = HilogChannel(3, 0xD003100, "CJ-UITEST")

/**
 * UITest
 * 
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
protected class UITest {
    /**
     * setup
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    protected static func setup(): Unit {
        if (!SETUP_CALLED.compareAndSwap(false, true)) {
            return
        }
        let testEnable = Systemparameter.get(TESTMODE_ENABLE, def: "0")
        if (testEnable != "1") {
            TEST_LOG.warn("UiTestKit_exporter: systemParameter \"${TESTMODE_ENABLE}\" is not set!")
        }
        let delegator = AbilityDelegatorRegistry.getAbilityDelegator()
        let appCtx = delegator.getAppContext()
        // used to start server & client
        let token = "${appCtx.applicationInfo.name}@${Process.pid}@${Process.uid}@${appCtx.area.getValue()}"
        // start client
        try (ctoken = unsafe { LibC.mallocCString(token) }.asResource()) {
            unsafe { CJ_InitConnection(ctoken.value) }
        }
        // start server
        let result = delegator.executeShellCommand("uitest start-daemon ${token}", timeoutSecs: 3)
        if (result.exitCode != 0) {
            TEST_LOG.error("uitest setup failed")
        }
    }
}
const INVALID_PARA: Int32 = 401
func getData(params: ApiCallParams, api: String): String {
    let ret = unsafe { CJ_ApiCall(params) }
    params.free()
    let dataOrMessage = ret.data.toString()
    unsafe { LibC.free(ret.data) }
    if (ret.code != 0) {
        if (ret.code == INVALID_PARA) {
            throw IllegalArgumentException(dataOrMessage)
        }
        throw BusinessException(ret.code, "${api} failed: ${dataOrMessage}")
    }
    return dataOrMessage
}

func releaseRef(ref: String) {
    unsafe {
        try (cref = LibC.mallocCString(ref).asResource()) {
            CJ_UITestObjDelete(cref.value)
        }
    }
}

func checkRef(ref: String) {
    if (!ref.contains("#")) {
        throw BusinessException(OBJ_LOST, "obj create return null reference")
    }
}

func checkNull(data: String): Bool {
    return data == "null"
}

/**
 * The unified facade of UiTest framework,can be used to find Component,trigger keyEvents,perform
 * coordinates-based UI actions,capture screen and so on.
 *
 * @relation declare class Driver
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class Driver {
    Driver(let ref: String) {
        checkRef(ref)
    }

    ~init() {
        releaseRef(ref)
    }

    /**
     * Create an Driver object.
     *
     * @throws { BusinessException } 17000001 - Initialization failed.
     * @relation static create(): Driver
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public static func create(): Driver {
        let cjCallParams = ApiCallParams(DRIVER_CREATE, "", EMPTY_PARAM)
        let data = getData(cjCallParams, DRIVER_CREATE)
        return Driver(data[1..data.size - 1])
    }

    /**
     * Delay with specified duration.
     *
     * @param { Int32 } duration - the delay duration in milliseconds, not less than 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation delayMs(duration: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func delayMs(duration: Int32): Unit {
        let cjCallParams = ApiCallParams(DRIVER_DELAYMS, ref, "[${duration}]")
        getData(cjCallParams, DRIVER_DELAYMS)
        return
    }

    /**
     * Find the first matched Component on current UI.
     *
     * @returns { ?Component } the first matched Component or undefined.
     * @relation findComponent(on: On): Promise<Component|null>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func findComponent(on: On): ?Component {
        let cjCallParams = ApiCallParams(DRIVER_FINDCOMPONENT, ref, "[\"${on.ref}\"]")
        let data = getData(cjCallParams, DRIVER_FINDCOMPONENT)
        if (checkNull(data)) {
            return Option<Component>.None
        }
        return Component(data[1..data.size - 1])
    }

    /**
     * Find all the matched Components on current UI.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation findComponents(on: On): Promise<Array<Component>|null>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func findComponents(on: On): ?Array<Component> {
        let cjCallParams = ApiCallParams(DRIVER_FINDCOMPONENTS, ref, "[\"${on.ref}\"]")
        let data = getData(cjCallParams, DRIVER_FINDCOMPONENTS)
        if (checkNull(data)) {
            return Option<Array<Component>>.None
        }
        let jsonArr = JsonValue.fromStr(data).asArray()
        let arr = Array<Component>(
            jsonArr.size(),
            {
                i => Component(
                    jsonArr.get(i).getOrThrow({=> BusinessException(OBJ_LOST, "wrong component")}).asString().getValue())
            }
        )
        return arr
    }

    /**
     * Find the first matched UiWindow window.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation findWindow(filter: WindowFilter): Promise<UiWindow|null>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func findWindow(filter: WindowFilter): ?UiWindow {
        let params: StringBuilder = StringBuilder("[{")
        var temp = false	
        if (let Some(v) <- filter.bundleName) {	
            params.append("\"bundleName\":\"${v}\"")	
            temp = true	
        }
        if (let Some(v) <- filter.title) {
            if (temp) {
                params.append(",")
            }
            params.append("\"title\":\"${v}\"")
            temp = true
        }
        if (let Some(v) <- filter.focused) {
            if (temp) {
                params.append(",")
            }
            params.append("\"focused\":${v}")
            temp = true
        }
        if (let Some(v) <- filter.active) {
            if (temp) {
                params.append(",")
            }
            params.append("\"active\":${v}")
        }
        if (let Some(v) <- filter.displayId) {
            if (temp) {
                params.append(",")
            }
           params.append("\"displayId\":${v}") 
        }
        params.append("}]")
        let cjCallParams = ApiCallParams(DRIVER_FINDWINDOW, ref, params.toString())
        let data = getData(cjCallParams, DRIVER_FINDWINDOW)
        if (checkNull(data)) {
            return Option<UiWindow>.None
        }
        return UiWindow(data[1..data.size - 1])
    }

    /**
     * Find the first matched Component on current UI during the time given.
     *
     * @param { Int32 } time - duration of finding in milliseconds, not less than 0.
     * @returns { ?Component } the first matched Component or undefined.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation waitForComponent(on: On, time: number): Promise<Component|null>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func waitForComponent(on: On, time: Int32): ?Component {
        let cjCallParams = ApiCallParams(DRIVER_WAITFORCOMPONENT, ref, "[\"${on.ref}\",${time}]")
        let data = getData(cjCallParams, DRIVER_WAITFORCOMPONENT)
        if (checkNull(data)) {
            return Option<Component>.None
        }
        return Component(data[1..data.size - 1])
    }
    /**
     * Assert t the matched Components exists on current UI;if not,assertError will be raised.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000003 - Assertion failed.
     * @relation assertComponentExist(on: On): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func assertComponentExist(on: On): Unit {
        let cjCallParams = ApiCallParams(DRIVER_ASSERTCOMPONENTEXIST, ref, "[\"${on.ref}\"]")
        getData(cjCallParams, DRIVER_ASSERTCOMPONENTEXIST)
        return
    }
    /**
     * Press the BACK key.
     *
     * @relation pressBack(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func pressBack(): Unit {
        let cjCallParams = ApiCallParams(DRIVER_PRESSBACK, ref, EMPTY_PARAM)
        getData(cjCallParams, DRIVER_PRESSBACK)
        return
    }

    /**
     * Press the specified key.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation triggerKey(keyCode: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func triggerKey(keyCode: Int32): Unit {
        let cjCallParams = ApiCallParams(DRIVER_TRIGGERKEY, ref, "[${keyCode}]")
        getData(cjCallParams, DRIVER_TRIGGERKEY)
        return
    }

    /**
     * Press two or three key combinations
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation triggerCombineKeys(key0: number, key1: number, key2?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func triggerCombineKeys(key0: Int32, key1: Int32, key2!: Int32 = 0): Unit {
        let params: StringBuilder = StringBuilder("[${key0},${key1},${key2}]")
        let cjCallParams = ApiCallParams(DRIVER_TRIGGERCOMBINEKEYS, ref, params.toString())
        getData(cjCallParams, DRIVER_TRIGGERCOMBINEKEYS)
        return
    }
    /**
     * Click on the specified location on the screen.
     *
     * @param { Int32 } x - the x-coordinate, not less than 0.
     * @param { Int32 } y - the y-coordinate, not less than 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation click(x: number, y: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func click(x: Int32, y: Int32): Unit {
        let cjCallParams = ApiCallParams(DRIVER_CLICK, ref, "[${x},${y}]")
        getData(cjCallParams, DRIVER_CLICK)
        return
    }
    /**
     * DoubleClick on the specified location on the screen.
     *
     * @param { Int32 } x - the x-coordinate, not less than 0.
     * @param { Int32 } y - the y-coordinate, not less than 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation doubleClick(x: number, y: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func doubleClick(x: Int32, y: Int32): Unit {
        let cjCallParams = ApiCallParams(DRIVER_DOUBLECLICK, ref, "[${x},${y}]")
        getData(cjCallParams, DRIVER_DOUBLECLICK)
        return
    }
    /**
     * LongClick on the specified location on the screen.
     *
     * @param { Int32 } x - the x-coordinate, not less than 0.
     * @param { Int32 } y - the y-coordinate, not less than 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation longClick(x: number, y: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func longClick(x: Int32, y: Int32): Unit {
        let cjCallParams = ApiCallParams(DRIVER_LONGCLICK, ref, "[${x},${y}]")
        getData(cjCallParams, DRIVER_LONGCLICK)
        return
    }
    /**
     * Swipe on the screen between the specified points.
     *
     * @param { Int32 } startx - the x-coordinate of the starting point, not less than 0.
     * @param { Int32 } starty - the y-coordinate of the starting point, not less than 0.
     * @param { Int32 } endx - the x-coordinate of the ending point, not less than 0.
     * @param { Int32 } endy - the y-coordinate of the ending point, not less than 0.
     * @param { Int32 } speed - the speed of swipe(pixels per second),ranges from 200 to 40000.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation swipe(startx: number, starty: number, endx: number, endy: number, speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func swipe(
        startx: Int32,
        starty: Int32,
        endx: Int32,
        endy: Int32,
        speed!: Int32 = 600
    ): Unit {
        let params = "[${startx},${starty},${endx},${endy},${speed}]"
        let cjCallParams = ApiCallParams(DRIVER_SWIPE, ref, params)
        getData(cjCallParams, DRIVER_SWIPE)
        return
    }
    /**
     * Drag on the screen between the specified points.
     *
     * @param { Int32 } startx - the x-coordinate of the starting point, not less than 0.
     * @param { Int32 } starty - the y-coordinate of the starting point, not less than 0.
     * @param { Int32 } endx - the x-coordinate of the ending point, not less than 0.
     * @param { Int32 } endy - the y-coordinate of the ending point, not less than 0.
     * @param { Int32 } [speed] the speed of drag(pixels per second),ranges from 200 to 40000.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation drag(startx: number, starty: number, endx: number, endy: number, speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func drag(
        startx: Int32,
        starty: Int32,
        endx: Int32,
        endy: Int32,
        speed!: Int32 = 600
    ): Unit {
        let params = "[${startx},${starty},${endx},${endy},${speed}]"
        let cjCallParams = ApiCallParams(DRIVER_DRAG, ref, params)
        getData(cjCallParams, DRIVER_DRAG)
        return
    }
    /**
     * Capture current screen and save as picture which PNG format.
     *
     * @param { String } savePath - the path where to store the picture, must be in the application sandbox directory.
     * @returns { Bool } true if screen-capturing and file-storing are completed successfully,false otherwise.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation screenCap(savePath: string): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func screenCap(savePath: String): Bool {
        let cjCallParams = ApiCallParams(DRIVER_SCREENCAP, ref, "[\"${eatEscape(savePath)}\"]")
        let data = getData(cjCallParams, DRIVER_SCREENCAP)
        return Bool.parse(data)
    }

    /**
     * Set the rotation of the device display.
     *
     * @param { DisplayRotation } rotation - the target rotation to set.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation setDisplayRotation(rotation: DisplayRotation): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func setDisplayRotation(rotation: DisplayRotation): Unit {
        let cjCallParams = ApiCallParams(DRIVER_SETDISPLAYROTATION, ref, "[${rotation.getValue()}]")
        getData(cjCallParams, DRIVER_SETDISPLAYROTATION)
        return
    }
    /**
     * Get the rotation of the device display.
     *
     * @returns { DisplayRotation } the current display rotation.
     * @relation getDisplayRotation(): Promise<DisplayRotation>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getDisplayRotation(): DisplayRotation {
        let cjCallParams = ApiCallParams(DRIVER_GETDISPLAYROTATION, ref, EMPTY_PARAM)
        let data = getData(cjCallParams, DRIVER_GETDISPLAYROTATION)
        return DisplayRotation.parse(data)
    }
    /**
     * Enable/disable the rotation of device display.
     *
     * @param { Bool } enabled - enable the rotation or not.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation setDisplayRotationEnabled(enabled: boolean): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func setDisplayRotationEnabled(enabled: Bool): Unit {
        let cjCallParams = ApiCallParams(DRIVER_SETDISPLAYROTATIONENABLED, ref, "[${enabled}]")
        getData(cjCallParams, DRIVER_SETDISPLAYROTATIONENABLED)
        return
    }

    /**
     * Get the size of the device display.
     *
     * @returns { Point } the size of the device display.
     * @relation getDisplaySize(): Promise<Point>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getDisplaySize(): Point {
        let cjCallParams = ApiCallParams(DRIVER_GETDISPLAYSIZE, ref, EMPTY_PARAM)
        let data = getData(cjCallParams, DRIVER_GETDISPLAYSIZE)
        Point(data)
    }

    /**
     * Get the density of the device display.
     *
     * @returns { Point } the density of the device display.
     * @relation getDisplayDensity(): Promise<Point>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getDisplayDensity(): Point {
        let cjCallParams = ApiCallParams(DRIVER_GETDISPLAYDENSITY, ref, EMPTY_PARAM)
        let data = getData(cjCallParams, DRIVER_GETDISPLAYDENSITY)
        Point(data)
    }
    /**
     * Wake up the device display.
     *
     * @relation wakeUpDisplay(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func wakeUpDisplay(): Unit {
        let cjCallParams = ApiCallParams(DRIVER_WAKEUPDISPLAY, ref, EMPTY_PARAM)
        getData(cjCallParams, DRIVER_WAKEUPDISPLAY)
        return
    }

    /**
     * Press the home key.
     *
     * @relation pressHome(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func pressHome(): Unit {
        let cjCallParams = ApiCallParams(DRIVER_PRESSHOME, ref, EMPTY_PARAM)
        getData(cjCallParams, DRIVER_PRESSHOME)
        return
    }
    /**
     * Wait for the UI become idle.
     *
     * @param { Int32 } idleTime - the threshold of UI idle time, in millisecond, not less than 0.
     * @param { Int32 } timeout - the maximum time to wait for idle, in millisecond, not less than 0.
     * @returns { Bool } true if wait for idle succeed in the timeout, false otherwise.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation waitForIdle(idleTime: number, timeout: number): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func waitForIdle(idleTime: Int32, timeout: Int32): Bool {
        let cjCallParams = ApiCallParams(DRIVER_WAITFORIDLE, ref, "[${idleTime},${timeout}]")
        let data = getData(cjCallParams, DRIVER_WAITFORIDLE)
        return Bool.parse(data)
    }
    /**
     * Inject multi-pointer action on the device display.
     *
     * @param { PointerMatrix } pointers - the two-dimensional array of pointers to inject.
     * @param { Int32 } [speed] - the speed of swipe(pixels per second),ranges from 200 to 40000. Set it default 600 if out of range or null or undefined.
     * @returns { Bool } true if the operation finished, false
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation injectMultiPointerAction(pointers: PointerMatrix, speed?: number): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func injectMultiPointerAction(pointers: PointerMatrix, speed!: Int32 = 600): Bool {
        let cjCallParams = ApiCallParams(DRIVER_INJECTMULTIPOINTERACTION, ref, "[\"${pointers.ref}\",${speed}]")
        let data = getData(cjCallParams, DRIVER_INJECTMULTIPOINTERACTION)
        return Bool.parse(data)
    }
    /**
     * Inject fling on the device display.
     *
     * @param { Point } from - the coordinate point where the finger touches the screen.
     * @param { Point } to - the coordinate point where the finger leaves the screen.
     * @param { Int32 } stepLen - the length of each step, in pixels.
     * @param { Int32 } speed - the speed of fling(pixels per second),ranges from 200 to 40000.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation fling(from: Point, to: Point, stepLen: number, speed: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func fling(from: Point, to: Point, stepLen: Int32, speed: Int32): Unit {
        let params: String = "[{\"x\":${from.x},\"y\":${from.y}},{\"x\":${to.x},\"y\":${to.y}},${stepLen},${speed}]"
        let cjCallParams = ApiCallParams(DRIVER_FLING, ref, params)
        getData(cjCallParams, DRIVER_FLING)
        return
    }
    /**
     * Inject fling on the device display.
     *
     * @param { UiDirection } direction - the direction of this action.
     * @param { Int32 } speed - the speed of fling (pixels per second), default is 600.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation fling(direction: UiDirection, speed: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func fling(direction: UiDirection, speed: Int32): Unit {
        let cjCallParams = ApiCallParams(DRIVER_FLING, ref, "[${direction.getValue()},${speed}]")
        getData(cjCallParams, DRIVER_FLING)
        return
    }
    /**
     * Capture the specified area of current screen and save as picture which PNG format.
     *
     * @param { String } savePath - the path where to store the picture, must be in the application sandbox directory.
     * @param { Rect } [rect] - the specified area of current screen, default to full screen.
     * @returns { Bool } true if screen-capturing and file-storing are completed successfully, false otherwise.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation screenCapture(savePath: string, rect?: Rect): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func screenCapture(savePath: String, rect!: Rect = Rect(0,0,0,0)): Bool {
        let params: StringBuilder = StringBuilder("[\"${eatEscape(savePath)}\"")
        params.append(",")
        params.append("{\"left\":${rect.left},\"top\":${rect.top},\"right\":${rect.right},\"bottom\":${rect.bottom}}")
        params.append("]")
        let cjCallParams = ApiCallParams(DRIVER_SCREENCAPTURE, ref, params.toString())
        let data = getData(cjCallParams, DRIVER_SCREENCAPTURE)
        return Bool.parse(data)
    }

    func parseClickParam(p: Point, btnId: MouseButton, key1: Int32, key2: Int32): String {
        let params: StringBuilder = StringBuilder("[{\"x\":${p.x},\"y\":${p.y}},${btnId.getValue()},${key1},${key2}]")
        params.toString()
    }
    /**
     * Click on the specified location on the screen with the specified mouse button, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { MouseButton } btnId - the button of Mouse.
     * @param { Int32 } key1 - the first keyCode,set default is 0.
     * @param { Int32 } key2 - the second keyCode,set idefault is 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseClick(p: Point, btnId: MouseButton, key1?: number, key2?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseClick(p: Point, btnId: MouseButton, key1!: Int32 = 0, key2!: Int32 = 0): Unit {
        let cjCallParams = ApiCallParams(DRIVER_MOUSECLICK, ref, parseClickParam(p, btnId, key1, key2))
        getData(cjCallParams, DRIVER_MOUSECLICK)
        return
    }
    /**
     * Move the mouse cursor to the specified location.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseMoveTo(p: Point): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseMoveTo(p: Point): Unit {
        let cjCallParams = ApiCallParams(DRIVER_MOUSEMOVETO, ref, "[{\"x\":${p.x},\"y\":${p.y}}]")
        getData(cjCallParams, DRIVER_MOUSEMOVETO)
        return
    }
    /**
     * Create an UIEventObserver object.
     *
     * @returns { UIEventObserver } the UIEventObserver object.
     * @relation createUIEventObserver(): UIEventObserver
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func createUIEventObserver(): UIEventObserver {
        let cjCallParams = ApiCallParams(DRIVER_CREATEUIEVENTOBSERVER, ref, EMPTY_PARAM)
        let data = getData(cjCallParams, DRIVER_CREATEUIEVENTOBSERVER)
        return UIEventObserver(data[1..data.size - 1])
    }
    /**
     * The mouse wheel scrolls the specified cell at the specified position, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { Bool } down - whether the mouse wheel rolls down.
     * @param { Int32 } d - the number of cells that the mouse wheel scrolls, each cell will make the target point shift 120 pixels.
     * @param { Int32 } key1 - the first keyCode, default is 0.
     * @param { Int32 } key2 - the second keyCode, default is 0.
     * @param { Int32 } speed - The Speed of mouse wheel rolls(cells per second),ranges from 1 to 500, default is 20.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseScroll(p: Point, down: boolean, d: number, key1?: number, key2?: number, speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseScroll(p: Point, down: Bool, d: Int32, key1!: Int32 = 0, key2!: Int32 = 0, speed!: Int32 = 20): Unit {
        let params: StringBuilder = StringBuilder("[{\"x\":${p.x},\"y\":${p.y}},${down},${d},${key1},${key2},${speed}]")
        let cjCallParams = ApiCallParams(DRIVER_MOUSESCROLL, ref, params.toString())
        getData(cjCallParams, DRIVER_MOUSESCROLL)
        return
    }

    /**
     * Double click on the specified location on the screen with the specified mouse button, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { MouseButton } btnId - the button of Mouse.
     * @param { Int32 } key1 - the first keyCode, default is 0.
     * @param { Int32 } key2 - the second keyCode, default is 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseDoubleClick(p: Point, btnId: MouseButton, key1?: number, key2?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseDoubleClick(p: Point, btnId: MouseButton, key1!: Int32 = 0, key2!: Int32 = 0): Unit {
        let cjCallParams = ApiCallParams(DRIVER_MOUSEDOUBLECLICK, ref, parseClickParam(p, btnId, key1, key2))
        getData(cjCallParams, DRIVER_MOUSEDOUBLECLICK)
        return
    }
    /**
     * Long click on the specified location on the screen with the specified mouse button, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { MouseButton } btnId - the button of Mouse.
     * @param { Int32 } key1 - the first keyCode, default is 0.
     * @param { Int32 } key2 - the second keyCode, default is 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseLongClick(p: Point, btnId: MouseButton, key1?: number, key2?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseLongClick(p: Point, btnId: MouseButton, key1!: Int32 = 0, key2!: Int32 = 0): Unit {
        let cjCallParams = ApiCallParams(DRIVER_MOUSELONGCLICK, ref, parseClickParam(p, btnId, key1, key2))
        getData(cjCallParams, DRIVER_MOUSELONGCLICK)
        return
    }
    /**
     * Swipe on the screen between the specified points with mouse.
     *
     * @param { Point } from - the starting point.
     * @param { Point } to - the ending point.
     * @param { Int32 } speed - speed of swipe (pixels per second),the value ranges from 200 to 40000, default is 600.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseMoveWithTrack(from: Point, to: Point, speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseMoveWithTrack(from: Point, to: Point, speed!: Int32 = 600): Unit {
        let params = "[{\"x\":${from.x},\"y\":${from.y}},{\"x\":${to.x},\"y\":${to.y}},${speed}]"
        let cjCallParams = ApiCallParams(DRIVER_MOUSEMOVEWITHTRACK, ref, params)
        getData(cjCallParams, DRIVER_MOUSEMOVEWITHTRACK)
        return
    }
    /**
     * Hold down the left mouse button and drag on the screen between the specified points.
     *
     * @param { Point } from - the starting point.
     * @param { Point } to - the ending point.
     * @param { Int32 } speed - speed of swipe (pixels per second),the value ranges from 200 to 40000, default is 600.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation mouseDrag(from: Point, to: Point, speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func mouseDrag(from: Point, to: Point, speed!: Int32 = 600): Unit {
        let params = "[{\"x\":${from.x},\"y\":${from.y}},{\"x\":${to.x},\"y\":${to.y}},${speed}]"
        let cjCallParams = ApiCallParams(DRIVER_MOUSEDRAG, ref, params)
        getData(cjCallParams, DRIVER_MOUSEDRAG)
        return
    }
    /**
     * Inject text on the specified location.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { String } text - the text to inject.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation inputText(p: Point, text: string): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func inputText(p: Point, text: String): Unit {
        let params: String = "[{\"x\":${p.x},\"y\":${p.y}},\"${eatEscape(text)}\"]"
        let cjCallParams = ApiCallParams(DRIVER_INPUTTEXT, ref, params)
        getData(cjCallParams, DRIVER_INPUTTEXT)
        return
    }
}

/**
 * Represents a two-dimensional array of pointers on the device display, it's used to build a
 * multi-finger trace which can be injected with UiDriver.
 *
 * @relation declare class PointerMatrix
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class PointerMatrix {
    PointerMatrix(protected let ref: String) {
        checkRef(ref)
    }

    ~init() {
        releaseRef(ref)
    }

    /**
     * Create an PointerMatrix object.
     *
     * @param { Int32 } fingers - The number of fingers, ranges from 1 to 10.
     * @param { Int32 } steps - The number of steps of each finger trace, ranges from 1 to 1000.
     * @returns { PointerMatrix } the PointerMatrix object.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation static create(fingers: number, steps: number): PointerMatrix
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public static func create(fingers: Int32, steps: Int32): PointerMatrix {
        let ffiParam = ApiCallParams(POINTERMATRIX_CREATE, "", "[${fingers},${steps}]")
        let data = getData(ffiParam, POINTERMATRIX_CREATE)
        return PointerMatrix(data[1..data.size - 1])
    }

    /**
     * Set the point value of an element in the PointerMatrix.
     *
     * @param { Int32 } finger - the index of target finger to set.
     * @param { Int32 } step - the index of target step to set.
     * @param { Point } point - the coordinate of target step to set.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation setPoint(finger: number, step: number, point: Point): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func setPoint(finger: Int32, step: Int32, point: Point): Unit {
        let ffiParam = ApiCallParams(POINTERMATRIX_SETPOINT, ref,
            "[${finger},${step},{\"x\":${point.x},\"y\":${point.y}}]")
        getData(ffiParam, POINTERMATRIX_SETPOINT)
        return
    }
}

/**
 * Represents a window of the ohos application,user can perform operations or query attributes on it.
 *
 * @relation declare class UiWindow
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class UiWindow {
    UiWindow(let ref: String) {
        checkRef(ref)
    }

    ~init() {
        releaseRef(ref)
    }

    /**
     * Get the bundle name of this UiWindow.
     *
     * @returns { String } the bundle name.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getBundleName(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getBundleName(): String {
        let ffiParam = ApiCallParams(UIWINDOW_GETBUNDLENAME, ref, EMPTY_PARAM)
        let data = getData(ffiParam, UIWINDOW_GETBUNDLENAME)
        return data[1..data.size - 1]
    }

    /**
     * Get the bounds rect of this UiWindow.
     *
     * @returns { Rect } the bounds rect object.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getBounds(): Promise<Rect>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getBounds(): Rect {
        let ffiParam = ApiCallParams(UIWINDOW_GETBOUNDS, ref, EMPTY_PARAM)
        let data = getData(ffiParam, UIWINDOW_GETBOUNDS)
        let jsonValue = JsonValue.fromStr(data)
        let jsonObject = jsonValue.asObject()
        let numBottom = Int32(jsonObject.get(STRING_BOTTOM).getOrThrow().asInt().getValue())
        let numLeft = Int32(jsonObject.get(STRING_LEFT).getOrThrow().asInt().getValue())
        let numRight = Int32(jsonObject.get(STRING_RIGHT).getOrThrow().asInt().getValue())
        let numTop = Int32(jsonObject.get(STRING_TOP).getOrThrow().asInt().getValue())
        return Rect(numLeft, numTop, numRight, numBottom)
    }

    /**
     * Get the title of this UiWindow.
     *
     * @returns { String } the title value.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getTitle(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getTitle(): String {
        let ffiParam = ApiCallParams(UIWINDOW_GETTITLE, ref, EMPTY_PARAM)
        let data = getData(ffiParam, UIWINDOW_GETTITLE)
        return data[1..data.size - 1]
    }

    /**
     * Get the window mode of this UiWindow.
     *
     * @returns { WindowMode } the WindowMode object
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getWindowMode(): Promise<WindowMode>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getWindowMode(): WindowMode {
        let ffiParam = ApiCallParams(UIWINDOW_GETWINDOWMODE, ref, EMPTY_PARAM)
        let data = getData(ffiParam, UIWINDOW_GETWINDOWMODE)
        return WindowMode.parse(data)
    }

    /**
     * Get the focused status of this UiWindow.
     *
     * @returns { Bool } the focused status
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation isFocused(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isFocused(): Bool {
        let ffiParam = ApiCallParams(UIWINDOW_ISFOCUSED, ref, EMPTY_PARAM)
        let data = getData(ffiParam, UIWINDOW_ISFOCUSED)
        Bool.parse(data)
    }

    /**
     * Set the focused status of this UiWindow.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation focus(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func focus(): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_FOCUS, ref, EMPTY_PARAM)
        getData(ffiParam, UIWINDOW_FOCUS)
        return
    }

    /**
     * Move this UiWindow to the specified points.
     *
     * @param { Int32 } x - the x coordinate of destination, not less than 0.
     * @param { Int32 } y - the y coordinate of destination, not less than 0.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation moveTo(x: number, y: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func moveTo(x: Int32, y: Int32): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_MOVETO, ref, "[${x},${y}]")
        getData(ffiParam, UIWINDOW_MOVETO)
        return
    }

    /**
     * Resize this UiWindow to the specified size for the specified direction.
     *
     * @param { Int32 } wide - the expected wide of the window after resizing.
     * @param { Int32 } height - the expected height of the window after resizing.
     * @param { ResizeDirection } direction - the expected direction of the window after resizing.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation resize(wide: number, height: number, direction: ResizeDirection): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func resize(wide: Int32, height: Int32, direction: ResizeDirection): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_RESIZE, ref, "[${wide},${height},${direction.getValue()}]")
        getData(ffiParam, UIWINDOW_RESIZE)
        return
    }

    /**
     * Change this UiWindow into split screen mode.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation split(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func split(): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_SPLIT, ref, EMPTY_PARAM)
        getData(ffiParam, UIWINDOW_SPLIT)
        return
    }

    /**
     * Maximize this UiWindow.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation maximize(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func maximize(): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_MAXIMIZE, ref, EMPTY_PARAM)
        getData(ffiParam, UIWINDOW_MAXIMIZE)
        return
    }

    /**
     * Minimize this UiWindow.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation minimize(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func minimize(): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_MINIMIZE, ref, EMPTY_PARAM)
        getData(ffiParam, UIWINDOW_MINIMIZE)
        return
    }

    /**
     * Resume this UiWindow.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation resume(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func resume(): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_RESUME, ref, EMPTY_PARAM)
        getData(ffiParam, UIWINDOW_RESUME)
        return
    }

    /**
     * Close this UiWindow.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessException } 17000005 - This operation is not supported.
     * @relation close(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func close(): Unit {
        let ffiParam = ApiCallParams(UIWINDOW_CLOSE, ref, EMPTY_PARAM)
        getData(ffiParam, UIWINDOW_CLOSE)
        return
    }

    /**
     * Get the active status of this UiWindow.
     *
     * @returns { Bool } the active status.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation isActive(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isActive(): Bool {
        let ffiParam = ApiCallParams(UIWINDOW_ISACTIVE, ref, EMPTY_PARAM)
        let data = getData(ffiParam, UIWINDOW_ISACTIVE)
        Bool.parse(data)
    }
}

/**
 * Describes the attribute requirements for the target Components.
 *
 * @relation declare class On
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class On {
    var ref: String = ON_SEED_REF
    /**
     * On constructor
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public init() {}

    ~init() {
        releaseRef(ref)
    }

    func apiCall(id: String, param: String): String {
        let ffiParam = ApiCallParams(id, ref, param)
        getData(ffiParam, id)
    }

    func boolParamCall(id: String, b: Bool): String {
        let param = "[${b.toString()}]"
        let data = apiCall(id, param)
        return data[1..data.size - 1]
    }

    func toParamString(p: String): String {
        return "[\"${p}\"]"
    }

    /**
     * Specifies the text attribute of the target component. Multiple match patterns are supported.
     *
     * @param { String } txt - Component text, used to match the target component.
     * @param { MatchPattern } pattern - Match pattern. The default value is EQUALS.
     * @returns { On } On object that matches the text attribute of the target component.
     * @relation text(txt: string, pattern?: MatchPattern): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func text(txt: String, pattern!: MatchPattern = MatchPattern.Equals): On {
        let param = "[\"${eatEscape(txt)}\",${pattern.getValue()}]"
        let data = apiCall(ON_TEXT, param)
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Specifies the id of the target Component.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation id(id: string): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func id(id: String): On {
        let data = apiCall(ON_ID, toParamString(eatEscape(id)))
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Specifies the type of the target Component.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation type(tp: string): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func onType(tp: String): On {
        let data = apiCall(ON_TYPE, toParamString(eatEscape(tp)))
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Specifies the description for the target Component.
     *
     * @param { MatchPattern } pattern - the MatchPattern of description value. The default value is EQUALS.
     * @throws { IllegalArgumentException } - if the input parameters are invalid.
     * @relation description(val: string, pattern?: MatchPattern): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func description(val: String, pattern!: MatchPattern = MatchPattern.Equals): On {
        let param = StringBuilder("[\"${eatEscape(val)}\",${pattern.getValue()}]")
        let data = apiCall(ON_DESCRIPTION, param.toString())
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Specifies the clickable attribute of the target component.
     *
     * @param { Bool } b - Clickable status of the target component. The default value is true.
     *                     true: clickable; false: not clickable.
     * @returns { On } On object that matches the clickable attribute of the target component.
     * @relation clickable(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func clickable(b!: Bool = true): On {
        ref = boolParamCall(ON_CLICKABLE, b)
        this
    }

    /**
     * Specifies the longClickable status of the target Component.
     *
     * @param { Bool } b - the longClickable status. The default value is true.
     * @returns { On } this {@link On} object.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation longClickable(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func longClickable(b!: Bool = true): On {
        ref = boolParamCall(ON_LONG_CLICKABLE, b)
        this
    }

    /**
     * Specifies the scrollable status of the target Component.
     *
     * @param { Bool } b - the scrollable status. The default value is true.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation scrollable(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func scrollable(b!: Bool = true): On {
        ref = boolParamCall(ON_SCROLLABLE, b)
        this
    }

    /**
     * Specifies the enabled status of the target Component.
     *
     * @param { Bool } b - the enabled status. The default value is true.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation enabled(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func enabled(b!: Bool = true): On {
        ref = boolParamCall(ON_ENABLED, b)
        this
    }

    /**
     * Specifies the focused status of the target Component.
     *
     * @param { Bool } b - the focused status. The default value is true.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation focused(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func focused(b!: Bool = true): On {
        ref = boolParamCall(ON_FOCUSED, b)
        this
    }

    /**
     * Specifies the selected status of the target Component.
     *
     * @param { Bool } b the - selected status. The default value is true.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation selected(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func selected(b!: Bool = true): On {
        ref = boolParamCall(ON_SELECTED, b)
        this
    }

    /**
     * Specifies the checked status of the target Component.
     *
     * @param { Bool } b - the checked status. The default value is true.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation checked(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func checked(b!: Bool = true): On {
        ref = boolParamCall(ON_CHECKED, b)
        this
    }

    /**
     * Specifies the checkable status of the target Component.
     *
     * @param { Bool } b - the checkable status. The default value is true.
     * @throws { IllegalArgumentException } - Parameter error. 1. Incorrect parameter types; 2. Parameter verification failed.
     * @relation checkable(b?: boolean): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func checkable(b!: Bool = true): On {
        ref = boolParamCall(ON_CHECKABLE, b)
        this
    }

    /**
     * Requires that the target Component which is before another Component that specified by the given On
     * object,used to locate Component relatively.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation isBefore(on: On): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isBefore(on: On): On {
        let data = apiCall(ON_IS_BEFORE, "[\"${on.ref}\"]")
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Requires that the target Component which is after another Component that specified by the given On
     * object,used to locate Component relatively.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation isAfter(on: On): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isAfter(on: On): On {
        let data = apiCall(ON_IS_AFTER, "[\"${on.ref}\"]")
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Requires that the target Component which is inside of another Component that specified by the given On
     * object,used to locate Component relatively.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation within(on: On): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func within(on: On): On {
        let data = apiCall(ON_WITHIN, "[\"${on.ref}\"]")
        ref = data[1..data.size - 1]
        this
    }

    /**
     * Specifies the bundleName of the application which the window that the target Component is located belongs.
     *
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation inWindow(bundleName: string): On
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func inWindow(bundleName: String): On {
        let data = apiCall(ON_IN_WINDOW, toParamString(eatEscape(bundleName)))
        ref = data[1..data.size - 1]
        this
    }
}

/**
 * The type of func once.
 *
 */
@Derive[ToString, Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public enum OnceType {
    /**
     * oastShow
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    ToastShow
    |
    /**
     * DialogShow
     * 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    DialogShow
    | ...
}

/**
 * Observer to monitor UI events.
 * 
 * @relation declare interface UIEventObserver
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class UIEventObserver {
    UIEventObserver(let ref: String) {
        checkRef(ref)
    }

    ~init() {
        releaseRef(ref)
    }
    /**
     * Listen for toast show once
     * 
     * @param { OnceType } onceType - the type of func once.
     * @param { Callback<UIElementInfo> } callback - function, returns the monitored UIElementInfo.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @relation once(type: 'toastShow', callback: Callback<UIElementInfo>): void
     * @relation once(type: 'dialogShow', callback: Callback<UIElementInfo>): void
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func once(onceType: OnceType, callback: Callback<UIElementInfo>): Unit {
        if (onceType == OnceType.ToastShow) {
            onceShow(TOAST, callback)
        }
        if (onceType == OnceType.DialogShow) {
            onceShow(DIALOG, callback)
        }
    }

    func onceShow(api: String, callback: Callback<UIElementInfo>): Unit {
        unsafe {
            let wrapper = {
                cUIElementInfo: CUIElementInfo =>
                let info = UIElementInfo(cUIElementInfo)
                callback(info)
            }
            let param = ApiCallParams(OBSERVER_ONCE, this.ref,
                api + Callback1Param<CUIElementInfo, Unit>(wrapper).getID().toString() + "]")
            let ret = CJ_ApiCall(param)
            param.free()
            let dataOrMessage = ret.data.toString()
            LibC.free(ret.data)
            if (ret.code != 0) {
                throw BusinessException(ret.code, "${api} failed: ${dataOrMessage}")
            }
        }
    }
}

/**
 * Represents a Component of the ohos application,user can perform operations or query attributes on it.
 *
 * @relation declare class Component 
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Test.UiTest"
]
public class Component {
    Component(let ref: String) {
        checkRef(ref)
    }

    ~init() {
        releaseRef(ref)
    }

    func apiCall(id: String, param: String): String {
        let ffiParam = ApiCallParams(id, ref, param)
        getData(ffiParam, id)
    }
    /**
     * Click this Component.
     *
     * @relation click(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func click(): Unit {
        apiCall(COMPONENT_CLICK, EMPTY_PARAM)
    }
    /**
     * Double click this Component.
     *
     * @returns { Unit }
     * @relation doubleClick(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func doubleClick(): Unit {
        apiCall(COMPONENT_DOUBLE_CLICK, EMPTY_PARAM)
    }
    /**
     * Long click this Component.
     *
     * @returns { Unit }
     * @relation longClick(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func longClick(): Unit {
        apiCall(COMPONENT_LONG_CLICK, EMPTY_PARAM)
    }
    /**
     * Get the id attribute value.
     *
     * @relation getId(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getId(): String {
        let data = apiCall(COMPONENT_GET_ID, EMPTY_PARAM)
        return data[1..data.size - 1]
    }
    /**
     * Get the text attribute value.
     *
     * @returns { String } the text value.
     * @relation getText(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getText(): String {
        let data = apiCall(COMPONENT_GET_TEXT, EMPTY_PARAM)
        return data[1..data.size - 1]
    }
    /**
     * Get the type name.
     *
     * @returns { String } the type name.
     * @relation getType(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getType(): String {
        let data = apiCall(COMPONENT_GET_TYPE, EMPTY_PARAM)
        return data[1..data.size - 1]
    }
    /**
     * Get the bounds rect of this Component.
     *
     * @returns { Rect } the bounds rect object.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getBounds(): Promise<Rect>
     */ 
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getBounds(): Rect {
        let jsonStr = apiCall(COMPONENT_GET_BOUNDS, EMPTY_PARAM)
        return Rect(jsonStr)
    }
    /**
     * Get the boundsCenter of this Component.
     *
     * @returns { Point } the boundsCenter object.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getBoundsCenter(): Promise<Point>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getBoundsCenter(): Point {
        let jsonStr = apiCall(COMPONENT_GET_BOUNDSCENTER, EMPTY_PARAM)
        return Point(jsonStr)
    }
    /**
     * Get the clickable status of this Component.
     *
     * @returns { Bool } the clickable status.
     * @relation isClickable(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isClickable(): Bool {
        let str = apiCall(COMPONENT_IS_CLICKABLE, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the clickable status of this Component.
     *
     * @returns { Bool } the clickable status.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation isLongClickable(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isLongClickable(): Bool {
        let str = apiCall(COMPONENT_IS_LONGCLICKABLE, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the checked status of this Component.
     *
     * @returns { Bool } the checked status.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation isChecked(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isChecked(): Bool {
        let str = apiCall(COMPONENT_IS_CHECKED, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the checkable status of this Component.
     *
     * @returns { Bool } the checkable status.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation isCheckable(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isCheckable(): Bool {
        let str = apiCall(COMPONENT_IS_CHECKABLE, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the scrollable status of this Component.
     *
     * @returns { Bool } the scrollable status.
     * @relation isScrollable(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isScrollable(): Bool {
        let str = apiCall(COMPONENT_IS_SCROLLABLE, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the enabled status of this Component.
     *
     * @returns { Bool } the enabled status.
     * @relation isEnabled(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isEnabled(): Bool {
        let str = apiCall(COMPONENT_IS_ENABLED, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the focused status of this Component.
     *
     * @returns { Bool } the focused status.
     * @relation isFocused(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isFocused(): Bool {
        let str = apiCall(COMPONENT_IS_FOCUSED, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Get the selected status of this Component.
     *
     * @returns { Bool } the selected status.
     * @relation isSelected(): Promise<boolean>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func isSelected(): Bool {
        let str = apiCall(COMPONENT_IS_SELECTED, EMPTY_PARAM)
        return Bool.parse(str)
    }
    /**
     * Inject text to this Component,applicable to TextInput.
     *
     * @param { String } text The text to inject.
     * @relation inputText(text: string): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func inputText(text: String): Unit {
        apiCall(COMPONENT_INPUT_TEXT, "[\"${eatEscape(text)}\"]")
    }
    /**
     * Clear text of this Component,applicable to TextInput.
     *
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation clearText(): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func clearText(): Unit {
        apiCall(COMPONENT_CLEAR_TEXT, EMPTY_PARAM)
    }
    /**
     * Scroll on this Componentto find matched Component,applicable to scrollable one.
     *
     * @param { On } on - the attribute requirements of the target Component.
     * @returns { ?Component } the found result,or undefined if not found.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation scrollSearch(on: On): Promise<Component|null>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func scrollSearch(on: On): ?Component {
        let data = apiCall(COMPONENT_SCROLL_SEARCH, "[\"${on.ref}\"]")
        if (checkNull(data)) {
            return Option<Component>.None
        }
        Component(data[1..data.size - 1])
    }
    /**
     * Scroll on this Component to the top,applicable to scrollable one.
     *
     * @param { Int64 } speed - the speed of swipe(pixels per second),ranges from 200 to 40000. The default value is 600.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation scrollToTop(speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func scrollToTop(speed!: Int64 = 600): Unit {
        apiCall(COMPONENT_SCROLL_TOTOP, "[${speed}]")
    }
    /**
     * Scroll on this Component to the bottom,applicable to scrollable one.
     *
     * @param { Int64 } speed - the speed of swipe(pixels per second),ranges from 200 to 40000. The default value is 600.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation scrollToBottom(speed?: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func scrollToBottom(speed!: Int64 = 600): Unit {
        apiCall(COMPONENT_SCROLL_TOBOTTOM, "[${speed}]")
    }
    /**
     * Drag this Component to the bounds rect of target Component.
     *
     * @param { Component } target - the target Component.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation dragTo(target: Component): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func dragTo(target: Component): Unit {
        apiCall(COMPONENT_DRAGTO, "[\"${target.ref}\"]")
    }
    /**
     * Pinch enlarge this Component to the target scale.
     *
     * @param { Float32 } scale - the scale of the pinch enlarge this Component's size, ranges greater than 1.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation pinchOut(scale: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func pinchOut(scale: Float32): Unit {
        apiCall(COMPONENT_PINCHOUT, "[${scale.format(".16")}]")
    }
    /**
     * Pinch shrink this Component to the target scale.
     *
     * @param { Float32 } scale - the scale of the pinch shrink this Component's size, ranges from 0 to 1.
     * @throws { IllegalArgumentException } - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation pinchIn(scale: number): Promise<void>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func pinchIn(scale: Float32): Unit {
        apiCall(COMPONENT_PINCHIN, "[${scale.format(".16")}]")
    }
    /**
     * Get the description attribute value.
     *
     * @returns { String } the description value.
     * @throws { BusinessException } 17000004 - The window or component is invisible or destroyed.
     * @relation getDescription(): Promise<string>
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Test.UiTest"
    ]
    public func getDescription(): String {
        let data = apiCall(COMPONENT_GET_DESCRIPTION, EMPTY_PARAM)
        return data[1..data.size - 1]
    }
}

func eatEscape(str: String): String {
    let tmp = StringBuilder()
    for (c in str.runes()) {
        let val = match (c) {
            case r'\t' => "\\t"
            case r'\b' => "\\b"
            case r'\r' => "\\r"
            case r'\n' => "\\n"
            case r'\f' => "\\f"
            case r'\v' => "\\v"
            case _ => "${c}"
        }
        tmp.append(val)
    }
    return tmp.toString()
}
