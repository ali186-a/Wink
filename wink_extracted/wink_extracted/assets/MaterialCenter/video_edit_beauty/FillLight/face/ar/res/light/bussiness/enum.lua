-- @author: lcx3@meitu.com
------ 序列帧
TouchState = {}
TouchState.BEGIN = 1
TouchState.MOVE = 2
TouchState.END = 3

EditType = {}
EditType.SHADOW = 1
EditType.FACE = 2
EditType.RIM = 3
EditType.DEPTH = 4

local Enum = {
    TouchState = TouchState, EditType = EditType
}

return Enum