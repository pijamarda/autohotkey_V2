#Requires AutoHotkey v2.0
#SingleInstance Force

holding := false

#HotIf WinActive("Minecraft")
+e:: {
    global holding
    KeyWait "Shift"            ; avoid a shift-click
    holding := !holding
    Click holding ? "Down" : "Up"
    ToolTip holding ? "Holding click" : "Released"
    SetTimer () => ToolTip(), -1000
}
#HotIf

; --- Autorun: R toggles holding W (only in Minecraft) ---
global autorunOn := false
AutorunOff(sendUp := true) {
    global autorunOn
    if !autorunOn
        return
    autorunOn := false
    if sendUp
        Send "{w up}"
    ToolTip "Autorun OFF"
    SetTimer () => ToolTip(), -1000
}
#HotIf WinActive("Minecraft")
*r:: {
    global autorunOn
    if autorunOn {
        AutorunOff()
    } else {
        autorunOn := true
        Send "{w down}"
        ToolTip "Autorun ON"
        SetTimer () => ToolTip(), -1000
    }
}
~*w:: AutorunOff(false)
~*s:: AutorunOff()
#HotIf
