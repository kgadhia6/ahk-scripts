#Requires AutoHotkey v2.0
#SingleInstance Force

; Global flag to track if F13 (i.e., Win key) is held down.
; This is used by the #HotIf directives below.
Global g_IsF13Active := false

; --- Context-Sensitive Block for Emacs ---
#HotIf WinActive("ahk_exe emacs.exe")

; -----------------------------------------------------------------
; 1 & 3: CapsLock -> Ctrl, No Toggle on Hold (Active when F13 is NOT held)
; -----------------------------------------------------------------
; This HotIf block is the most critical: we check the *LOGICAL* state of F13.
; If F13 is logically down (due to your LWin/RWin remapping), we skip this block.
#HotIf WinActive("ahk_exe emacs.exe") and !GetKeyState("F13", "L")
{
    ; CapsLock remaps to LCtrl. Using the scan code is still best practice here.
    *SC03A::
    {
        Send "{LCtrl down}"
        KeyWait "SC03A"
        Send "{LCtrl up}"
    }
}

; -----------------------------------------------------------------
; 2: F13 + CapsLock -> Toggles CapsLock LED and functionality
; -----------------------------------------------------------------
; This hotkey fires when F13 is logically down (due to your LWin/RWin remapping).
; Using the logical state of F13 makes the combination fire reliably.
F13 & SC03A::
{
    ; Since the Ctrl remapping is disabled by the #HotIf check above, 
    ; we can safely and reliably toggle the state now.
    CurrentState := GetKeyState("CapsLock", "T") 
    
    if (CurrentState = 1)
        SetCapsLockState("Off")
    else
        SetCapsLockState("On")
        
    return
}

#HotIf ; End global context-sensitive block