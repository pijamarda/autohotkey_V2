#Requires AutoHotkey v2.0
CoordMode "Mouse", "Client"
F9:: {
    if !WinExist("ahk_exe Wow.exe") {
        MsgBox "WoW window NOT found"
        return
    }
    WinActivate
    WinGetClientPos , , &w, &h
    x := Round(w*0.900), y := Round(h*0.944)
    MsgBox "Found WoW " w "x" h "`nAdmin: " (A_IsAdmin ? "yes" : "no") "`nWill click at " x "," y
    WinActivate
    Sleep 500
    MouseMove x, y, 5
    Sleep 200
    Click
}