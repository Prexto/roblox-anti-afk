; ============================================================
;  Anti-AFK para Roblox — AutoHotkey v1.1
; ============================================================

#NoEnv
#SingleInstance Force
#Persistent
#WinActivateForce
; NO usar SendMode Input — Roblox/Byfron lo bloquea
; Default = SendEvent (keybd_event API) que sí funciona

jumpCount  := 0
isActive   := true

; ---------- GUI ----------
Gui, +AlwaysOnTop +ToolWindow
Gui, Color, 1a1a2e

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, Text, x10 y12 w280 Center, 🎮 Anti-AFK Roblox

Gui, Font, s10 c00ff99 Bold, Segoe UI
Gui, Add, Text, vStatusText x10 y50 w280 Center, ● ACTIVO

Gui, Font, s9 cWhite Normal, Segoe UI
Gui, Add, Text, vJumpText x10 y80 w280 Center, Saltos: 0

Gui, Font, s9 cff4444 Normal, Segoe UI
Gui, Add, Text, vErrorText x10 y105 w280 Center,

Gui, Font, s8 c888888 Normal, Segoe UI
Gui, Add, Text, x10 y130 w280 Center, F1 = Pausar   |   F2 = Salir

Gui, Show, w300 h160, Anti-AFK Roblox

SetTimer, DoJump, 3000
return

; ============================================================
DoJump:
    if (!isActive)
        return

    if !WinExist("ahk_exe RobloxPlayerBeta.exe") {
        GuiControl,, ErrorText, ⚠ Roblox no encontrado
        return
    }

    ; PRIMERO actualizar GUI — antes de tocar el foco
    jumpCount++
    GuiControl,, ErrorText,
    GuiControl,, JumpText, Saltos realizados: %jumpCount%

    ; Activar Roblox y ESPERAR a que esté activo de verdad
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    WinWaitActive, ahk_exe RobloxPlayerBeta.exe,, 2
    if (ErrorLevel) ; no se pudo activar en 2 seg
        return
    SendEvent, {Space down}
    Sleep, 150
    SendEvent, {Space up}
return

; ============================================================
F1::
    isActive := !isActive
    if (isActive) {
        GuiControl,, StatusText, ● ACTIVO
        GuiControl,, ErrorText,
    } else {
        GuiControl,, StatusText, ⏸ PAUSADO
        GuiControl,, ErrorText,
    }
return

F2::
GuiClose:
    ExitApp
return
