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

import ohos.labels.*
import ohos.ffi.*
import ohos.business_exception.*
import ohos.hilog.*
import std.collection.*

const LOG_CORE: UInt32 = 3
const LOG_TAG_DOMAIN_ID_PARA: UInt32 = 0xD002C0C
const MAX_NAME_LENGTH = 128
const MAX_VALUE_LENGTH = 4096
let PARAM_LOG = HilogChannel(LOG_CORE, LOG_TAG_DOMAIN_ID_PARA, "CJ-Param")

foreign func FfiOHOSSysTemParameterGet(key: CString, def: CString): RetDataCString

foreign func FfiOHOSSysTemParameterSet(key: CString, value: CString): Int32

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (14700101, "System parameter can not be found."),
        (14700102, "System parameter value is invalid."),
        (14700103, "System permission operation permission denied."),
        (14700104, "System internal error including out of memory, deadlock etc.")
    ]
)

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Unknown error. Error code is ${code}"
    }
}

protected class Systemparameter {
    protected static func get(key: String, def!: String = ""): String {
        unsafe {
            // invalid parameter error
            if (key.size >= MAX_NAME_LENGTH || def.size >= MAX_VALUE_LENGTH) {
                PARAM_LOG.error("Systemparameter get failed: ${getErrorMsg(ERR_PARAMETER_ERROR)}")
                throw BusinessException(ERR_PARAMETER_ERROR,
                    "Systemparameter get failed: ${getErrorMsg(ERR_PARAMETER_ERROR)}")
            }
            let cKey = LibC.mallocCString(key)
            let cDef = LibC.mallocCString(def)
            let ret = FfiOHOSSysTemParameterGet(cKey, cDef)
            LibC.free(cKey)
            LibC.free(cDef)
            if (ret.code != 0) {
                PARAM_LOG.error("Systemparameter get failed: ${getErrorMsg(ret.code)}")
                throw BusinessException(ret.code, "Systemparameter get failed: ${getErrorMsg(ret.code)}")
            }
            return getStringAndFree(ret.data)
        }
    }

    protected static func set(key: String, value: String): Unit {
        unsafe {
            // invalid parameter error
            if (key.size >= MAX_NAME_LENGTH || value.size >= MAX_VALUE_LENGTH) {
                PARAM_LOG.error("Systemparameter set failed: ${getErrorMsg(ERR_PARAMETER_ERROR)}")
                throw BusinessException(ERR_PARAMETER_ERROR,
                    "Systemparameter set failed: ${getErrorMsg(ERR_PARAMETER_ERROR)}")
            }
            let cKey = LibC.mallocCString(key)
            let cVal = LibC.mallocCString(value)
            let ret = FfiOHOSSysTemParameterSet(cKey, cVal)
            LibC.free(cKey)
            LibC.free(cVal)
            if (ret != 0) {
                PARAM_LOG.error("Systemparameter get failed: ${getErrorMsg(ret)}")
                throw BusinessException(ret, "Systemparameter get failed: ${getErrorMsg(ret)}")
            }
        }
    }
}

func getStringAndFree(value: CString): String {
    unsafe {
        let result = value.toString()
        LibC.free(value)
        return result
    }
}
