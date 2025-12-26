#Requires AutoHotkey v2.0+

#HotIf WinActive("ahk_exe emacs.exe")  ; Only active in Emacs

; Left Windows key → hold F13
LWin:: {
    Send("{F13 down}")
}
LWin up:: {
    Send("{F13 up}")
}

; Right Windows key → hold F13
RWin:: {
    Send("{F13 down}")
}
RWin up:: {
    Send("{F13 up}")
}

#HotIf  ; End context-sensitive block
