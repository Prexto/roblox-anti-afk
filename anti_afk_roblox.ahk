; ============================================================
;  Anti-AFK para Roblox — AutoHotkey v1.1
; ============================================================

#NoEnv
#SingleInstance Force
#Persistent
#WinActivateForce
; Default SendEvent (keybd_event API) — no usar SendInput, Byfron lo bloquea

jumpCount  := 0
isActive   := true

; ---------- CONFIGURACIÓN VISUAL ----------
W := 260
H := 170
BG_COLOR     := "0x0d1117"    ; fondo principal (GitHub dark)
HEADER_COLOR := "0x161b22"    ; barra de título
ACCENT       := "0x58a6ff"    ; azul acento
GREEN        := "0x3fb950"    ; verde activo
RED          := "0xf85149"    ; rojo error/pausado
GRAY         := "0x8b949e"    ; texto secundario
WHITE        := "0xc9d1d9"    ; texto principal

; ---------- GUI ----------
Gui, +AlwaysOnTop -Caption +ToolWindow +HwndGuiHwnd
Gui, Color, %BG_COLOR%
Gui, Margin, 0, 0

; Barra de título custom (draggable)
titleBarW := W - 56
Gui, Add, Text, x0 y0 w%titleBarW% h28 Background%HEADER_COLOR% vTitleBar gDragWindow
Gui, Font, s9 c%ACCENT% Bold, Segoe UI
Gui, Add, Text, x12 y5 w150 h20 Background%HEADER_COLOR% gDragWindow, ANTI-AFK  //  ROBLOX
Gui, Font, s7 c%GRAY% Normal, Segoe UI
byX := titleBarW - 75
Gui, Add, Text, x%byX% y8 w70 h16 Right Background%HEADER_COLOR% gDragWindow, by Prexto
Gui, Font, s9 c%WHITE% Bold, Segoe UI
minX := W - 56
Gui, Add, Text, x%minX% y3 w28 h24 Center gMinimizeGui vMinBtn, _
Gui, Font, s9 c%RED% Bold, Segoe UI
closeX := W - 28
Gui, Add, Text, x%closeX% y3 w28 h24 Center gCloseApp vCloseBtn, X

; Línea separadora
Gui, Add, Progress, x0 y28 w%W% h1 Background%ACCENT%

; Estado
Gui, Font, s11 c%GREEN% Bold, Segoe UI
Gui, Add, Text, vStatusText x0 y40 w%W% h25 Center, ACTIVO

; Contador de saltos
Gui, Font, s10 c%WHITE% Normal, Segoe UI
Gui, Add, Text, vJumpText x0 y68 w%W% h20 Center, Saltos: 0

; Línea de error (oculta por defecto)
Gui, Font, s8 c%RED% Normal, Segoe UI
Gui, Add, Text, vErrorText x0 y93 w%W% h18 Center,

; Separador inferior
sepY := H - 40
Gui, Add, Progress, x15 y%sepY% w230 h1 Background%HEADER_COLOR%

; Controles
Gui, Font, s8 c%GRAY% Normal, Segoe UI
ctrlY := H - 30
Gui, Add, Text, x0 y%ctrlY% w%W% h20 Center, F1 Pausar  |  F2 Salir

Gui, Show, w%W% h%H%, Anti-AFK Roblox

; Borde de 1px usando Region (visual hack)
WinSet, Region, 0-0 %W%-0 %W%-%H% 0-%H%, ahk_id %GuiHwnd%

SetTimer, DoJump, 3000
return

; ---------- DRAG WINDOW ----------
DragWindow:
    PostMessage, 0xA1, 2,,, ahk_id %GuiHwnd%  ; WM_NCLBUTTONDOWN
return

; ============================================================
DoJump:
    if (!isActive)
        return

    if !WinExist("ahk_exe RobloxPlayerBeta.exe") {
        GuiControl,, ErrorText, ! Roblox no encontrado
        return
    }

    ; PRIMERO actualizar GUI — antes de tocar el foco
    jumpCount++
    GuiControl,, ErrorText,
    GuiControl,, JumpText, Saltos: %jumpCount%

    ; Activar Roblox y ESPERAR a que esté activo de verdad
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    WinWaitActive, ahk_exe RobloxPlayerBeta.exe,, 2
    if (ErrorLevel)
        return
    SendEvent, {Space down}
    Sleep, 150
    SendEvent, {Space up}
return

; ============================================================
F1::
    isActive := !isActive
    if (isActive) {
        Gui, Font, c%GREEN%
        GuiControl, Font, StatusText
        GuiControl,, StatusText, ACTIVO
        GuiControl,, ErrorText,
    } else {
        Gui, Font, c%RED%
        GuiControl, Font, StatusText
        GuiControl,, StatusText, PAUSADO
        GuiControl,, ErrorText,
    }
return

MinimizeGui:
    Gui, Minimize
return

CloseApp:
F2::
GuiClose:
    ExitApp
return
