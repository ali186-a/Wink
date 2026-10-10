ui = {
    order = {"displayBG", "fgColor"},
    displayBG = { ui_type = "switch", value = false, ui_name_tw = "显示背景", ui_name_en = "Display back ground", ui_name = "显示背景" },
    fgColor = { ui_name = "前景颜色", ui_name_en = "fgColor", r = 255.00, a = 0.00, b = 0.00, g = 0.00, ui_type = "color", ui_format = "r&g&b&a" },
}

paramTable = {}
 
paramTable["MVAR"] = {
    order = ui.order,
    switch1 = ui.displayBG,
    color1 = ui.fgColor
}
return {ui = ui, paramTable = paramTable}