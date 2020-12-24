#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



IfExist, %SystemDrive%\Program Files (x86) ; If this folder exists system is 64bit
{
    GLOBAL OS_bitrate := "64bit"
}
Else,
{
    GLOBAL OS_bitrate := "32bit"
}


MsgBox,, Operating system Info,
(
OS Bitrate: %OS_bitrate%
)






; OS_bitrate := Is64bit()
;  MsgBox, %OS_bitrate%

; Is64bit(){
;         ; MsgBox, %A_PtrSize% 
;     Return A_PtrSize = 8 ? 1 : 0

; }

;In 64 bit AHK L A_PtrSize is 8, in 32 bit AHK_L it is 4 and in AHK Basic it is blank. 