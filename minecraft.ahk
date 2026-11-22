#Requires AutoHotkey v2.0
#SingleInstance Force

; Minecraft helpers (only active while the Minecraft window is focused)
;   Shift+E : toggle holding the left mouse button (mining / attacking)
;   R       : toggle autorun (holds W). Pressing W or S yourself also stops it.

global holdingClick := false
global autorunOn := false

ShowTip(text) {
    ToolTip text
    SetTimer () => ToolTip(), -1000
}

StopAutorun(sendUp := true) {
    global autorunOn
    if !autorunOn
        return
    autorunOn := false
    if sendUp
        Send "{w up}"
    ShowTip "Autorun OFF"
}

#HotIf WinActive("Minecraft")

+e:: {
    global holdingClick
    holdingClick := !holdingClick
    if holdingClick {
        KeyWait "Shift"
        Click "Down"
        ShowTip "Hold click ON"
    } else {
        Click "Up"
        ShowTip "Hold click OFF"
    }
}

*r:: {
    global autorunOn
    if autorunOn {
        StopAutorun()
    } else {
        autorunOn := true
        Send "{w down}"
        ShowTip "Autorun ON"
    }
}

; Pressing W yourself: you now hold W, so releasing it stops you normally.
~*w:: StopAutorun(false)

; Pressing S: release W so you stop / walk back.
~*s:: StopAutorun()

#HotIf

; Safety: if Minecraft loses focus, release anything still held.
SetTimer CheckFocus, 250
CheckFocus() {
    global holdingClick, autorunOn
    if WinActive("Minecraft")
        return
    if autorunOn {
        autorunOn := false
        Send "{w up}"
    }
    if holdingClick {
        holdingClick := false
        Click "Up"
    }
}
