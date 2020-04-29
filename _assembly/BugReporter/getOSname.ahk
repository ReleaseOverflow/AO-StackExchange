#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;; https://docs.microsoft.com/en-us/windows/win32/sysinfo/operating-system-version


i := GetOSVersion()
If (i = 5.0)
    GLOBAL OS_name := "Windows 2000"
If (i = 5.1)
    GLOBAL OS_name := "Windows XP"
Else If (i = 5.2)
    GLOBAL OS_name := "Windows XP Professional x64 Edition"
Else If (i = 6.0)
    GLOBAL OS_name := "Windows Vista"
Else If (i = 6.1)
    GLOBAL OS_name := "WIndows 7"
Else If (i = 6.2)
    GLOBAL OS_name := "Windows 8"
Else If (i = 6.3)
    GLOBAL OS_name := "Windows 8.1"
Else If (i = 10.0)
    GLOBAL OS_name := "Windows 10"
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
OS Name: %OS_name%
OS Version: %A_OSVersion%
OS Bitrate: %OS_bitrate%
)


GetOSVersion() {
    Return ((r := DllCall("GetVersion") & 0xFFFF) & 0xFF) "." (r >> 8)
}

