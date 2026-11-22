#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode "Mouse", "Client"

; Button positions as fractions of the WoW window (from your screenshots)
FINISH := [0.900, 0.944]
OKAY   := [0.502, 0.522]

running := false

^h:: {
    global running
    running := !running
    if running {
        ToolTip "Auto-retry ON"
        SetTimer () => ToolTip(), -1500
        SetTimer DoCycle, -100          ; start right away
    } else {
        SetTimer DoCycle, 0
        ToolTip "Auto-retry OFF"
        SetTimer () => ToolTip(), -1500
    }
}

^Esc::ExitApp

DoCycle() {
    global running
    if !running || !WinExist("ahk_exe Wow.exe")
        return
    WinActivate
    WinWaitActive(, , 2)
    ClickAt(FINISH)
    Sleep 5000
    if !running
        return
    ClickAt(OKAY)
    SetTimer DoCycle, -Random(60000, 120000)   ; next try in 1-2 min
}

ClickAt(pos) {
    WinGetClientPos , , &w, &h
    x := Round(w * pos[1]), y := Round(h * pos[2])
    MouseMove x, y, 5
    Sleep Random(80, 200)
    Click
}