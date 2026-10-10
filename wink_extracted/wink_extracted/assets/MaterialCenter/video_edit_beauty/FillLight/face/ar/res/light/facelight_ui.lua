-- @author: lcx3@meitu.com
------ ui
local Enum
if import ~= nil then
    Enum = import("bussiness/enum", false)
else
    TouchState = {}
    TouchState.BEGIN = 1
    TouchState.MOVE = 2
    TouchState.END = 3

    EditType = {}
    EditType.SHADOW = 1
    EditType.FACE = 2
    EditType.RIM = 3
    EditType.DEPTH = 4

    Enum = {
        TouchState = TouchState, EditType = EditType
    }

end

ui = { 
    defaultStrong = 0.88,
    temperature = { precision = 2.00, value = 0.00, step = 0.10, ui_type = "slider", ui_name = "色温", min = -1.00, max = 1.00, visible = true },
    z = { precision = 0.00, value = 100.00, step = 1.0, ui_type = "slider", ui_name = "z", min = 32.00, max = 100.00, visible = true },
    rim = { 
        visible = false, ui_name = "轮廓光", ui_type = "groupbox",
        filtertype = { 
            value = 1.00, ui_name = "背景叠加模式", ui_type = "combox",
            items = { 
                { name = "通用" },
                { lutPath = "PSBlend/BlendNormal.jpg", name = "正常" },
                { lutPath = "PSBlend/BlendDarken.jpg", name = "变暗" },
                { lutPath = "PSBlend/BlendMultiply.jpg", name = "正片叠底" },
                { lutPath = "PSBlend/BlendColorBurn.jpg", name = "颜色加深" },
                { lutPath = "PSBlend/BlendLinearBurn.jpg", name = "线性加深" },
                { lutPath = "PSBlend/BlendDarkerColor.jpg", name = "深色" },
                { lutPath = "PSBlend/BlendLighten.jpg", name = "变亮" },
                { lutPath = "PSBlend/BlendScreen.jpg", name = "滤色" },
                { lutPath = "PSBlend/BlendColorDodge.jpg", name = "颜色减淡" },
                { lutPath = "PSBlend/BlendLinearDodge.jpg", name = "线性减淡(添加)" },
                { lutPath = "PSBlend/BlendLighterColor.jpg", name = "浅色" },
                { lutPath = "PSBlend/BlendOverlay.jpg", name = "叠加" },
                { lutPath = "PSBlend/BlendSoftLight.jpg", name = "柔光" },
                { lutPath = "PSBlend/BlendHardLight.jpg", name = "强光" },
                { lutPath = "PSBlend/BlendVividLight.jpg", name = "亮光" },
                { lutPath = "PSBlend/BlendLinearLight.jpg", name = "线性光" },
                { lutPath = "PSBlend/BlendPinLight.jpg", name = "点光" },
                { lutPath = "PSBlend/BlendHardMix.jpg", name = "实色混合" },
                { lutPath = "PSBlend/BlendDifference.jpg", name = "差值" },
                { lutPath = "PSBlend/BlendExclusion.jpg", name = "排除" },
                { lutPath = "PSBlend/BlendSubtract.jpg", name = "减去" },
                { lutPath = "PSBlend/BlendDivide.jpg", name = "划分" }
            }
        },
        order = { "maskDebug", "blur", "debug", "filtertype" },
        blur = { precision = 2.00, value = 2.66, ui_name = "羽化程度:", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
        maskDebug = { 
            ui_name = "mask调整", ui_type = "groupbox",
            method = { 
                value = 1.00, ui_name = "方式", ui_name_tw = "方式", ui_type = "radioGroup", ui_name_en = "Methods",
                items = { 
                    { name = "缩进", name_tw = "缩进", name_en = "缩进" },
                    { name = "扩大", name_tw = "扩大", name_en = "扩大" }
                }
            },
            strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 500.00 },
            upper = { value = 100.00, ui_name = "上限:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
            lower = { value = 0.00, ui_name = "下限:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
            order = { "method", "strength", "lower", "upper" }
        },
        debug = { 
            value = 1.00, ui_name = "方式", ui_name_tw = "方式", ui_type = "radioGroup", ui_name_en = "Methods",
            items = { 
                { name = "分割", name_tw = "分割", name_en = "分割" },
                { name = "深度", name_tw = "深度", name_en = "深度" }
            }
        },
        rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", b = 255.00, r = 255.00 }
    },
    order = { "strong", "temperature", "z", "editType", "effect_check", "select_light", "depthLight", "faceLight", "shadow", "rim" },
    effect_check = { 
        ui_name = "功能开关", ui_name_en = "effect check", ui_name_tw = "功能开关", ui_type = "checkbox",
        items = { 
            { value = true, name = "人脸阴影" },
            { value = false, name = "霓虹光" },
            { value = false, name = "轮廓光" },
            { value = false, name = "深度" }
        }
    },
    shadow = { 
        visible = true, ui_name = "人脸", ui_type = "groupbox",
        lightMax = { precision = 2.00, value = 1.05, ui_name = "最大:", ui_type = "slider", step = 0.02, min = 0.00, max = 2.00 },
        order = { "blur", "erosion", "lightMax", "lightMin", "lightInfo" },
        lightMin = { precision = 2.00, value = 1.35, ui_name = "阴影程度:", ui_type = "slider", step = 0.02, min = 0.00, max = 2.00 },
        blur = { precision = 2.00, value = 4.45, ui_name = "羽化程度:", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
        erosion = { precision = 2.00, value = 0.00, ui_name = "腐蚀程度:", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
        lightInfo = { 
            ui_name = "平行光", ui_type = "groupbox",
            light_1 = { 
                materialColorKey = "u_directionLightColor[0]", ui_title = true, ui_name = "平行光1:", ui_type = "groupbox", materialKey = "u_directionLightDirection[0]", ui_common = false,
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                direction_y = { valueFactor = 100.00, value = 10.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", b = 285.69, r = 255.00 },
                strength = { value = 100.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                direction_z = { valueFactor = 100.00, value = 300.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            order = { "light_1", "light_2", "light_3", "light_4", "light_5" },
            light_4 = { 
                materialColorKey = "u_directionLightColor[3]", ui_title = true, ui_fold = true, ui_name = "平行光4:", ui_type = "groupbox", materialKey = "u_directionLightDirection[3]", ui_common = false,
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", b = 285.69, r = 255.00 },
                direction_z = { valueFactor = 100.00, value = 100.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            light_2 = { 
                materialColorKey = "u_directionLightColor[1]", ui_title = true, ui_fold = false, ui_name = "平行光2:", ui_type = "groupbox", materialKey = "u_directionLightDirection[1]", ui_common = false,
                direction_y = { valueFactor = 100.00, value = 10.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", b = 285.69, r = 255.00 },
                direction_z = { valueFactor = 100.00, value = 300.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            light_3 = { 
                materialColorKey = "u_directionLightColor[2]", ui_title = true, ui_fold = true, ui_name = "平行光3:", ui_type = "groupbox", materialKey = "u_directionLightDirection[2]", ui_common = false,
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                direction_x = { valueFactor = 100.00, value = -300.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = -68.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", b = 285.69, r = 255.00 },
                direction_z = { valueFactor = 100.00, value = -235.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            light_5 = { 
                materialColorKey = "u_directionLightColor[4]", ui_title = true, ui_fold = true, ui_name = "平行光5:", ui_type = "groupbox", materialKey = "u_directionLightDirection[4]", ui_common = false,
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", b = 285.69, r = 255.00 },
                direction_z = { valueFactor = 100.00, value = 100.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            }
        }
    },
    faceLight = { 
        visible = false, ui_name = "人脸", ui_type = "groupbox",
        filtertype = { 
            value = 1.00, ui_name = "背景叠加模式", ui_type = "combox",
            items = { 
                { name = "通用" },
                { lutPath = "PSBlend/BlendNormal.jpg", name = "正常" },
                { lutPath = "PSBlend/BlendDarken.jpg", name = "变暗" },
                { lutPath = "PSBlend/BlendMultiply.jpg", name = "正片叠底" },
                { lutPath = "PSBlend/BlendColorBurn.jpg", name = "颜色加深" },
                { lutPath = "PSBlend/BlendLinearBurn.jpg", name = "线性加深" },
                { lutPath = "PSBlend/BlendDarkerColor.jpg", name = "深色" },
                { lutPath = "PSBlend/BlendLighten.jpg", name = "变亮" },
                { lutPath = "PSBlend/BlendScreen.jpg", name = "滤色" },
                { lutPath = "PSBlend/BlendColorDodge.jpg", name = "颜色减淡" },
                { lutPath = "PSBlend/BlendLinearDodge.jpg", name = "线性减淡(添加)" },
                { lutPath = "PSBlend/BlendLighterColor.jpg", name = "浅色" },
                { lutPath = "PSBlend/BlendOverlay.jpg", name = "叠加" },
                { lutPath = "PSBlend/BlendSoftLight.jpg", name = "柔光" },
                { lutPath = "PSBlend/BlendHardLight.jpg", name = "强光" },
                { lutPath = "PSBlend/BlendVividLight.jpg", name = "亮光" },
                { lutPath = "PSBlend/BlendLinearLight.jpg", name = "线性光" },
                { lutPath = "PSBlend/BlendPinLight.jpg", name = "点光" },
                { lutPath = "PSBlend/BlendHardMix.jpg", name = "实色混合" },
                { lutPath = "PSBlend/BlendDifference.jpg", name = "差值" },
                { lutPath = "PSBlend/BlendExclusion.jpg", name = "排除" },
                { lutPath = "PSBlend/BlendSubtract.jpg", name = "减去" },
                { lutPath = "PSBlend/BlendDivide.jpg", name = "划分" }
            }
        },
        order = { "blur", "filtertype", "lightInfo" },
        blur = { precision = 2.00, value = 4.15, ui_name = "羽化程度:", ui_type = "slider", step = 0.00, min = 0.00, max = 5.00 },
        lightInfo = { 
            ui_name = "平行光", ui_type = "groupbox",
            light_1 = { 
                materialColorKey = "u_directionLightColor[0]", ui_name = "平行光1:", ui_type = "groupbox", materialKey = "u_directionLightDirection[0]", ui_common = false,
                strength = { value = 66.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                rgb = { g = 193.00, ui_format = "r&g&b", ui_type = "color", r = 208.00, b = 24.00 },
                direction_x = { valueFactor = 100.00, value = 300.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                direction_z = { valueFactor = 100.00, value = 0.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            order = { "light_1", "light_2", "light_3", "light_4", "light_5" },
            light_4 = { 
                materialColorKey = "u_directionLightColor[3]", ui_name = "平行光4:", ui_type = "groupbox", materialKey = "u_directionLightDirection[3]", ui_common = false,
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", r = 255.00, b = 255.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                direction_z = { valueFactor = 100.00, value = 100.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            light_2 = { 
                materialColorKey = "u_directionLightColor[1]", ui_name = "平行光2:", ui_type = "groupbox", materialKey = "u_directionLightDirection[1]", ui_common = false,
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", r = 255.00, b = 255.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                direction_z = { valueFactor = 100.00, value = 100.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            light_3 = { 
                materialColorKey = "u_directionLightColor[2]", ui_name = "平行光3:", ui_type = "groupbox", materialKey = "u_directionLightDirection[2]", ui_common = false,
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", r = 255.00, b = 255.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                direction_z = { valueFactor = 100.00, value = 100.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            },
            light_5 = { 
                materialColorKey = "u_directionLightColor[4]", ui_name = "平行光5:", ui_type = "groupbox", materialKey = "u_directionLightDirection[4]", ui_common = false,
                strength = { value = 0.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                rgb = { g = 255.00, ui_format = "r&g&b", ui_type = "color", r = 255.00, b = 255.00 },
                direction_x = { valueFactor = 100.00, value = 0.00, ui_name = "位置x:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                direction_y = { valueFactor = 100.00, value = 0.00, ui_name = "位置y:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 },
                order = { "rgb", "direction_x", "direction_y", "direction_z", "strength" },
                direction_z = { valueFactor = 100.00, value = 100.00, ui_name = "位置z:", ui_type = "slider", step = 1.00, min = -300.00, max = 300.00 }
            }
        }
    },
    editType = { 
        ui_type = "radioGroup", value = 1.00, ui_name = "当前选择类型",
        items = { 
            { name = "人脸阴影" },
            { name = "霓虹光" },
            { name = "轮廓光" },
            { name = "深度" }
        }
    },
    depthLight = { 
        visible = false, ui_name = "深度", ui_type = "groupbox",
        filtertype = { 
            value = 1.00, ui_name = "混合模式", ui_name_en = "Blend Mode", ui_name_tw = "混合模式", ui_type = "combox",
            items = { 
                { name = "正常", name_tw = "正常", name_en = "Normal" },
                { lutPath = "PSBlend/BlendDarken.jpg", name = "变暗", name_tw = "變暗", name_en = "Darken" },
                { lutPath = "PSBlend/BlendMultiply.jpg", name = "正片叠底", name_tw = "色彩增值", name_en = "Multiply" },
                { lutPath = "PSBlend/BlendColorBurn.jpg", name = "颜色加深", name_tw = "顏色加深", name_en = "Color burn" },
                { lutPath = "PSBlend/BlendLinearBurn.jpg", name = "线性加深", name_tw = "線性加深", name_en = "Linear burn" },
                { lutPath = "PSBlend/BlendDarkerColor.jpg", name = "深色", name_tw = "深色", name_en = "Dark" },
                { lutPath = "PSBlend/BlendLighten.jpg", name = "变亮", name_tw = "變亮", name_en = "Lighten" },
                { lutPath = "PSBlend/BlendScreen.jpg", name = "滤色", name_tw = "濾色", name_en = "Screen" },
                { lutPath = "PSBlend/BlendColorDodge.jpg", name = "颜色减淡", name_tw = "顏色減淡", name_en = "Color dodge" },
                { lutPath = "PSBlend/BlendLinearDodge.jpg", name = "线性减淡(添加)", name_tw = "線性減淡 (增加)", name_en = "Linear dodge (Add)" },
                { lutPath = "PSBlend/BlendLighterColor.jpg", name = "浅色", name_tw = "淺色", name_en = "Light" },
                { lutPath = "PSBlend/BlendOverlay.jpg", name = "叠加", name_tw = "疊加", name_en = "Overlay" },
                { lutPath = "PSBlend/BlendSoftLight.jpg", name = "柔光", name_tw = "柔光", name_en = "Soft light" },
                { lutPath = "PSBlend/BlendHardLight.jpg", name = "强光", name_tw = "強光", name_en = "Hard light" },
                { lutPath = "PSBlend/BlendVividLight.jpg", name = "亮光", name_tw = "亮光", name_en = "Vivid light" },
                { lutPath = "PSBlend/BlendLinearLight.jpg", name = "线性光", name_tw = "線性光", name_en = "Linear light" },
                { lutPath = "PSBlend/BlendPinLight.jpg", name = "点光", name_tw = "點光", name_en = "Pin light" },
                { lutPath = "PSBlend/BlendHardMix.jpg", name = "实色混合", name_tw = "實色疊印混合", name_en = "Hard mix" },
                { lutPath = "PSBlend/BlendDifference.jpg", name = "差值", name_tw = "差異化", name_en = "Difference" },
                { lutPath = "PSBlend/BlendExclusion.jpg", name = "排除", name_tw = "排除", name_en = "Exclusion" },
                { lutPath = "PSBlend/BlendSubtract.jpg", name = "减去", name_tw = "相減", name_en = "Subtract" },
                { lutPath = "PSBlend/BlendDivide.jpg", name = "划分", name_tw = "分割", name_en = "Divide" }
            }
        },
        lightInfo = { 
            ui_name = "光源", ui_type = "groupbox",
            light_1 = { 
                ui_name = "光源1", ui_type = "groupbox",
                touchDepth = { 
                    value = 1.00, ui_name = "深度为z", ui_name_tw = "深度为z", ui_type = "radioGroup", ui_name_en = "Depth Z",
                    items = { 
                        { name = "使用图片的深度", name_tw = "使用图片的深度", name_en = "使用图片的深度" },
                        { name = "使用坐标的深度", name_tw = "使用坐标的深度", name_en = "使用坐标的深度" }
                    }
                },
                strength = { value = 33.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                pow = { precision = 2.00, value = 1.11, ui_name = "羽化程度", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
                z = { value = 68.00, ui_name = "光源深度:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                position = { precision = 2.00, max = 100.00, ui_name = "位置:", min = 0.00, ui_type = "position", ui_format = "x&y", x = 58.24, y = 57.50 },
                radius = { value = 100.00, ui_name = "大小", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                order = { "rgb", "position", "z", "strength", "pow", "radius", "follow", "touchDepth" },
                follow = { 
                    value = 1.00, ui_name = "跟随人脸", ui_name_tw = "跟随人脸", ui_type = "radioGroup", ui_name_en = "Follow Face",
                    items = { 
                        { name = "跟随", name_tw = "跟随", name_en = "跟随" },
                        { name = "不跟随", name_tw = "不跟随", name_en = "不跟随" }
                    }
                },
                rgb = { g = 237.00, ui_format = "r&g&b", ui_type = "color", b = 211.00, r = 255.00 }
            },
            order = { "light_1", "light_2", "light_3", "light_4", "light_5" },
            light_4 = { 
                ui_name = "光源4", ui_type = "groupbox",
                touchDepth = { 
                    value = 2.00, ui_name = "深度为z", ui_name_tw = "深度为z", ui_type = "radioGroup", ui_name_en = "Depth Z",
                    items = { 
                        { name = "使用图片的深度", name_tw = "使用图片的深度", name_en = "使用图片的深度" },
                        { name = "使用坐标的深度", name_tw = "使用坐标的深度", name_en = "使用坐标的深度" }
                    }
                },
                strength = { value = 59.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                pow = { precision = 2.00, value = 1.53, ui_name = "羽化程度", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
                z = { value = 59.00, ui_name = "光源深度:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                position = { precision = 2.00, max = 100.00, ui_name = "位置:", min = 0.00, ui_type = "position", ui_format = "x&y", x = 94.07, y = 37.29 },
                radius = { value = 81.00, ui_name = "大小", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                order = { "rgb", "position", "z", "strength", "pow", "radius", "follow", "touchDepth" },
                follow = { 
                    value = 1.00, ui_name = "跟随人脸", ui_name_tw = "跟随人脸", ui_type = "radioGroup", ui_name_en = "Follow Face",
                    items = { 
                        { name = "跟随", name_tw = "跟随", name_en = "跟随" },
                        { name = "不跟随", name_tw = "不跟随", name_en = "不跟随" }
                    }
                },
                rgb = { g = 248.00, ui_format = "r&g&b", ui_type = "color", b = 222.00, r = 255.00 }
            },
            light_2 = { 
                ui_name = "光源2", ui_type = "groupbox",
                touchDepth = { 
                    value = 2.00, ui_name = "深度为z", ui_name_tw = "深度为z", ui_type = "radioGroup", ui_name_en = "Depth Z",
                    items = { 
                        { name = "使用图片的深度", name_tw = "使用图片的深度", name_en = "使用图片的深度" },
                        { name = "使用坐标的深度", name_tw = "使用坐标的深度", name_en = "使用坐标的深度" }
                    }
                },
                strength = { value = 63.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                pow = { precision = 2.00, value = 1.27, ui_name = "羽化程度", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
                z = { value = 67.00, ui_name = "光源深度:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                position = { precision = 2.00, max = 100.00, ui_name = "位置:", min = 0.00, ui_type = "position", ui_format = "x&y", x = 41.02, y = 49.03 },
                radius = { value = 42.00, ui_name = "大小", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                order = { "rgb", "position", "z", "strength", "pow", "radius", "follow", "touchDepth" },
                follow = { 
                    value = 1.00, ui_name = "跟随人脸", ui_name_tw = "跟随人脸", ui_type = "radioGroup", ui_name_en = "Follow Face",
                    items = { 
                        { name = "跟随", name_tw = "跟随", name_en = "跟随" },
                        { name = "不跟随", name_tw = "不跟随", name_en = "不跟随" }
                    }
                },
                rgb = { g = 235.00, ui_format = "r&g&b", ui_type = "color", b = 222.00, r = 255.00 }
            },
            light_3 = { 
                ui_name = "光源3", ui_type = "groupbox",
                touchDepth = { 
                    value = 2.00, ui_name = "深度为z", ui_name_tw = "深度为z", ui_type = "radioGroup", ui_name_en = "Depth Z",
                    items = { 
                        { name = "使用图片的深度", name_tw = "使用图片的深度", name_en = "使用图片的深度" },
                        { name = "使用坐标的深度", name_tw = "使用坐标的深度", name_en = "使用坐标的深度" }
                    }
                },
                strength = { value = 81.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                pow = { precision = 2.00, value = 1.00, ui_name = "羽化程度", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
                z = { value = 13.00, ui_name = "光源深度:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                position = { precision = 2.00, max = 100.00, ui_name = "位置:", min = 0.00, ui_type = "position", ui_format = "x&y", x = 30.46, y = 37.78 },
                radius = { value = 95.00, ui_name = "大小", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                order = { "rgb", "position", "z", "strength", "pow", "radius", "follow", "touchDepth" },
                follow = { 
                    value = 1.00, ui_name = "跟随人脸", ui_name_tw = "跟随人脸", ui_type = "radioGroup", ui_name_en = "Follow Face",
                    items = { 
                        { name = "跟随", name_tw = "跟随", name_en = "跟随" },
                        { name = "不跟随", name_tw = "不跟随", name_en = "不跟随" }
                    }
                },
                rgb = { g = 106.00, ui_format = "r&g&b", ui_type = "color", b = 57.00, r = 147.00 }
            },
            light_5 = { 
                ui_name = "光源5", ui_type = "groupbox",
                touchDepth = { 
                    value = 2.00, ui_name = "深度为z", ui_name_tw = "深度为z", ui_type = "radioGroup", ui_name_en = "Depth Z",
                    items = { 
                        { name = "使用图片的深度", name_tw = "使用图片的深度", name_en = "使用图片的深度" },
                        { name = "使用坐标的深度", name_tw = "使用坐标的深度", name_en = "使用坐标的深度" }
                    }
                },
                strength = { value = 142.00, ui_name = "透明度", ui_type = "slider", step = 1.00, min = 0.00, max = 200.00 },
                pow = { precision = 2.00, value = 1.19, ui_name = "羽化程度", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
                z = { value = 72.00, ui_name = "光源深度:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                position = { precision = 2.00, max = 100.00, ui_format = "x&y", ui_name = "位置:", ui_type = "position", min = 0.00, x = 84.85, y = 41.18 },
                radius = { value = 36.00, ui_name = "大小", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
                order = { "rgb", "position", "z", "strength", "pow", "radius", "follow", "touchDepth" },
                follow = { 
                    value = 1.00, ui_name = "跟随人脸", ui_name_tw = "跟随人脸", ui_type = "radioGroup", ui_name_en = "Follow Face",
                    items = { 
                        { name = "跟随", name_tw = "跟随", name_en = "跟随" },
                        { name = "不跟随", name_tw = "不跟随", name_en = "不跟随" }
                    }
                },
                rgb = { g = 214.00, ui_format = "r&g&b", ui_type = "color", b = 142.00, r = 255.00 }
            }
        },
        mask_animation = { 
            path = "gp/texture/mask/mask_.png", ui_name = "遮罩:", ui_type = "video", fps = 15.00,
            info = { 1.00, 5.00, 2.00, 2.00, 1.00, 0.00, 0.00 }
        },
        debug = { 
            value = 1.00, ui_name = "方式", ui_name_tw = "方式", ui_type = "radioGroup", ui_name_en = "Methods",
            items = { 
                { name = "分割", name_tw = "分割", name_en = "分割" },
                { name = "深度", name_tw = "深度", name_en = "深度" }
            }
        },
        ambient = { value = 76.00, ui_name = "环境:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
        order = { "ambient", "maskDebug", "debug", "showPoint", "filtertype", "blur", "mask_animation", "fps", "select_light", "lightInfo", "pointDebug" },
        fps = { value = 15.00, ui_name = "fps:", ui_type = "slider", step = 1.00, min = 0.00, max = 24.00 },
        blur = { precision = 2.00, value = 1.65, ui_name = "羽化程度:", ui_type = "slider", step = 0.05, min = 0.00, max = 5.00 },
        maskDebug = { 
            ui_fold = true, ui_name = "mask调整", ui_type = "groupbox",
            order = { "method", "strength" },
            strength = { value = 0.00, step = 1.00, ui_type = "slider", min = 0.00, max = 500.00 },
            method = { 
                value = 1.00, ui_name = "方式", ui_name_tw = "方式", ui_type = "radioGroup", ui_name_en = "Methods",
                items = { 
                    { name = "缩进", name_tw = "缩进", name_en = "缩进" },
                    { name = "扩大", name_tw = "扩大", name_en = "扩大" }
                }
            }
        },
        showPoint = { 
            value = 2.00, ui_name = "显示点", ui_name_tw = "方式", ui_type = "radioGroup", ui_name_en = "Methods",
            items = { 
                { name = "开", name_tw = "开", name_en = "开" },
                { name = "关", name_tw = "关", name_en = "关" }
            }
        },
        pointDebug = { 
            visible = false, ui_name = "point_debug", ui_type = "groupbox",
            pointParam_w = { value = 50.00, ui_name = "w:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
            order = { "pointParam_x", "pointParam_y", "pointParam_z", "pointParam_w" },
            pointParam_z = { value = 32.00, ui_name = "z:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
            pointParam_x = { value = 100.00, ui_name = "x:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 },
            pointParam_y = { value = 90.00, ui_name = "y:", ui_type = "slider", step = 1.00, min = 0.00, max = 100.00 }
        }
    },
    strong = { precision = 2.00, value = 1.00, ui_name = "客户端强度", ui_type = "slider", min = 0.00, max = 1.00 },
    select_light = { 
        value = 1.00, ui_name = "选择光", ui_type = "combox",
        items = { 
            { name = "1" },
            { name = "2" },
            { name = "3" },
            { name = "4" },
            { name = "5" }
        }
    }
}

ui.h_groupMap = false
ui.groupMap = {}
ui.groupMap[Enum.EditType.DEPTH] = ui.depthLight
ui.depthLight.h_groupMap = false
ui.depthLight.groupMap = {}
ui.depthLight.groupMap["lightInfo.light_1"] = ui.depthLight.lightInfo.light_1
ui.depthLight.groupMap["lightInfo.light_2"] = ui.depthLight.lightInfo.light_2
ui.depthLight.groupMap["lightInfo.light_3"] = ui.depthLight.lightInfo.light_3
ui.depthLight.groupMap["lightInfo.light_4"] = ui.depthLight.lightInfo.light_4
ui.depthLight.groupMap["lightInfo.light_5"] = ui.depthLight.lightInfo.light_5

ui.groupMap[Enum.EditType.FACE] = ui.faceLight
ui.faceLight.h_groupMap = false
ui.faceLight.groupMap = {}
ui.faceLight.groupMap["lightInfo.light_1"] = ui.faceLight.lightInfo.light_1
ui.faceLight.groupMap["lightInfo.light_2"] = ui.faceLight.lightInfo.light_2
ui.faceLight.groupMap["lightInfo.light_3"] = ui.faceLight.lightInfo.light_3
ui.faceLight.groupMap["lightInfo.light_4"] = ui.faceLight.lightInfo.light_4
ui.faceLight.groupMap["lightInfo.light_5"] = ui.faceLight.lightInfo.light_5

ui.groupMap[Enum.EditType.SHADOW] = ui.shadow
ui.shadow.h_groupMap = false
ui.shadow.groupMap = {}
ui.shadow.groupMap["lightInfo.light_1"] = ui.shadow.lightInfo.light_1
ui.shadow.groupMap["lightInfo.light_2"] = ui.shadow.lightInfo.light_2
ui.shadow.groupMap["lightInfo.light_3"] = ui.shadow.lightInfo.light_3
ui.shadow.groupMap["lightInfo.light_4"] = ui.shadow.lightInfo.light_4
ui.shadow.groupMap["lightInfo.light_5"] = ui.shadow.lightInfo.light_5

ui.groupMap[Enum.EditType.RIM] = ui.rim
ui.rim.h_groupMap = false
ui.rim.groupMap = {}

ui.defaultStrong = 0.88

paramTable = {}
paramTable["MVAR"] = {
    order = {"brightness", "colorTemperature", "dirX", "dirY", "z" },
    brightness = {ui_type = "slider", value = 0.5, min = 0.0, max = 1.0, precision = 2},
    colorTemperature = {
        ui_type = "slider", value = 0.0, min = -1.0, max = 1.0,
    },
    dirX = {ui_type = "slider", value = 0.0, min = -300.0, max = 300.0,},
    dirY = {ui_type = "slider", value = 10.0, min = -300.0, max = 300.0,},
    z = {ui_type = "slider", value = 88.0, min = 0.0, max = 200.0,}
}

return {ui = ui, paramTable = paramTable}