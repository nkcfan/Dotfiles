#Requires AutoHotkey v2.0

InstallKeybdHook

;; Use Alt+Wheel to tune volume
;; ref: https://www.autohotkey.com/boards/viewtopic.php?style=19&t=95079#p422500
; WheelUp::
; +WheelUp::
!WheelUp::Send "{Blind}{Volume_Up}"
; WheelDown::
; +WheelDown::
!WheelDown::Send "{Blind}{Volume_Down}"
; ^WheelUp::Send "{WheelUp}"
; ^WheelDown::Send "{WheelDown}"


;; Use Pause to mute mic
Pause::#!k

;; Use Alt+V to paste
!v::+Ins
!V::+Ins

;; Select full file name when renaming on Windows
;; ref: https://superuser.com/a/114907
#HotIf WinActive("ahk_class CabinetWClass")
$F2::Send "{F2}^a"
#HotIf
