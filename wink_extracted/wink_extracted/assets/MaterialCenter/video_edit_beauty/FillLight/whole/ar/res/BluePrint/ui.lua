paramTable = {}
paramTable["MVAR"] = {
    order = {"brightness", "colorTemperature", "tone", "dirX", "dirY", "z"},
    brightness = {
        ui_type = "slider", value = 0.5, min = 0.0, max = 1.0, targetNodeID = 2, nodeParam = "bp_setLightStrong"
    },
    colorTemperature = {
        ui_type = "slider", value = 0.0, min = -1.0, max = 1.0, targetNodeID = 1, nodeParam = "bp_setEnvColor"
    },
    tone = {
        ui_type = "slider", value = 0.0, min = -1.0, max = 1.0, targetNodeID = 1, nodeParam = "bp_setEnvColor"
    },
    dirX = {
        ui_type = "slider", value = 0, min = -3, max = 3.0, targetNodeID = 2, nodeParam = "bp_setLightPosX"
    },
    dirY = {
        ui_type = "slider", value = 0.0, min = -3, max = 3.0, targetNodeID = 2, nodeParam = "bp_setLightPosY"
    },
    z = {
        ui_type = "slider", value = 5.0, min = -5, max = 5.0, targetNodeID = 2, nodeParam = "bp_setLightPosZ"
    }
}

return { paramTable = paramTable}