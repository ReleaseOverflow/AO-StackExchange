#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; https://autohotkey.com/board/topic/3470-checkbox-example/






GLOBAL MultiSelectErrorStringGfx := "You checked too many graphics options.  The system will only accept one graphical preset input at a time, please try again."

Notepad = Somepath on your drive goes here (C:\WINDOWS) 
Gui, Add, Checkbox, x16 y17 w100 h30 vOpt8, Plugin 01
Opt8_TT := "Plugin 01 Information."
Gui, Add, Checkbox, x16 y57 w100 h30 vOpt7, Plugin 02
Opt7_TT := "Plugin 02 Information."
Gui, Add, Checkbox, x16 y97 w100 h30 vOpt6, Plugin 03
Opt6_TT := "Plugin 03 Information."
Gui, Add, Checkbox, x16 y137 w100 h30 vOpt5, Plugin 04
Opt5_TT := "Plugin 04 Information."
Gui, Add, Checkbox, x16 y177 w100 h30 vOpt4, Plugin 05
Opt4_TT := "Plugin 05 Information."
Gui, Add, Checkbox, x16 y253 w100 h30 vOpt3 gResetOther3, LOW
Opt3_TT := "The LOW Preset is the lowest graphical option preset available."
Gui, Add, Checkbox, x16 y293 w100 h30 vOpt2 gResetOther2, MEDIUM
Opt2_TT := "The MEDIUM Preset is the moderate graphical option preset."
Gui, Add, Checkbox, x16 y333 w100 h30 vOpt1 gResetOther1, ULTRA
Opt1_TT := "The ULTRA Preset is the highest graphical option preset available."

Gui, Add, Text, x136 y17 w100 h30, Test Plugin 01
Gui, Add, Text, x136 y57 w100 h30, Test Plugin 02
Gui, Add, Text, x136 y97 w100 h30, Test Plugin 03
Gui, Add, Text, x136 y137 w100 h30, Test Plugin 04
Gui, Add, Text, x136 y177 w100 h30, Test Plugin 05
Gui, Add, Text, x58 y230 w200 h50 vGraphicalPresets,   GRAPHICAL OPTIONS

Gui, Add, Text, x136 y293 w100 h30, LOW Graphical Options Preset
Gui, Add, Text, x136 y257 w100 h30, MEDIUM Graphical Options Preset
Gui, Add, Text, x136 y333 w100 h30, ULTRA Graphical Options Preset
Gui, Add, Button, gLabel x260 y90 w100 h60 vSumbitBtn, SUBMIT
SumbitBtn_TT := "Submit Changes to test.ini."
Gui, Add, Picture, gMyOtherLabel x275 y15 w50 h50, cut.ico ;Click on your image to run notepad.
Gui, Show, x159 y116 h379 w400, %ProjectName% %engine_version% %engine_terms% %ENGINEAPIs%  3.4 

; Sleep, 50
IniRead, PluginState_01, %A_ScriptDir%\test.ini, PLUGINS, Plugin_01, KEY ERROR @ PLUGINSTATE_01
IniRead, PluginState_02, %A_ScriptDir%\test.ini, PLUGINS, Plugin_02, KEY ERROR @ PLUGINSTATE_01
IniRead, PluginState_03, %A_ScriptDir%\test.ini, PLUGINS, Plugin_03, KEY ERROR @ PLUGINSTATE_01
IniRead, PluginState_04, %A_ScriptDir%\test.ini, PLUGINS, Plugin_04, KEY ERROR @ PLUGINSTATE_01
IniRead, PluginState_05, %A_ScriptDir%\test.ini, PLUGINS, Plugin_05, KEY ERROR @ PLUGINSTATE_01
;-----
IniRead, GfxPreset_LOW, %A_ScriptDir%\test.ini, API, GfxPreset_LOW, KEY ERROR @ GRAPHICS PRESET LOW
IniRead, GfxPreset_MEDIUM, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM, KEY ERROR @ GRAPHICS PRESET MEDIUM
IniRead, GfxPreset_ULTRA, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA, KEY ERROR @ GRAPHICS PRESET ULTRA
; Sleep, 50

; MsgBox, %PluginState_01%
If GfxPreset_LOW = TRUE
{
    GuiControl,, Opt3, 1
}
If GfxPreset_MEDIUM = TRUE
{
    GuiControl,, Opt2, 1
}
If GfxPreset_ULTRA = TRUE
{
    GuiControl,, Opt1, 1
}
If (GfxPreset_LOW = FALSE) and (GfxPreset_MEDIUM = FALSE) and (GfxPreset_ULTRA = FALSE)
{
    MsgBox, you have not selected a graphics presets, defaulting to MEDIUM GRAPHICS 
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
    GuiControl,, Opt2, 1
}


If PluginState_01 = TRUE
{
    GuiControl,, Opt8, 1
}
If PluginState_02 = TRUE
{
    GuiControl,, Opt7, 1
}
If PluginState_03 = TRUE
{
    GuiControl,, Opt6, 1
}
If PluginState_04 = TRUE
{
    GuiControl,, Opt5, 1
}
If PluginState_05 = TRUE
{
    GuiControl,, Opt4, 1
}
OnMessage(0x200, "WM_MOUSEMOVE")  ;;; https://www.autohotkey.com/docs/commands/Gui.htm#ExToolTip
Return 

Label: 
Gui, Submit, NoHide ;this command submits the guis' datas' state 
If (Opt1 = 1) and (Opt2 = 1) and (Opt3 = 1)
{
    MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
    Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
    Return
}
If (Opt1 = 0) and (Opt2 = 0) and (Opt3 = 0)
{
    MsgBox, 32, ERROR, No graphics profile selected, defaulting to MEDIUM
    IniWrite, TRUE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
    Resets_forDefaultingOpts()  ;; default graphics profile to 
    Return
}
If (Opt1 = 1) and (Opt2 = 1)
{
    MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
    Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
    Return
}
If (Opt1 = 1) and (Opt3 = 1)
{
    MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
    Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
    Return
}
If (Opt2 = 1) and (Opt3 = 1)
{
    MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
    Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
    Return
}









If (Opt1 = 1)
{
    MsgBox, you selected ULTRA GRAPHICS 
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
}
If (Opt1 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
}



If (Opt2 = 1)
{
    MsgBox, you selected MEDIUM GRAPHICS 
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
}
If (Opt2 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
}




If (Opt3 = 1)
{
    MsgBox, you selected LOW GRAPHICS 
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
}
If (Opt3 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
}


If (Opt1 = 0) and (Opt2 = 0) and (Opt3 = 0)
{
    MsgBox, you have not selected a graphics presets, defaulting to MEDIUM GRAPHICS 
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, API, GfxPreset_MEDIUM
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_LOW
    IniWrite, FALSE, %A_ScriptDir%\test.ini, API, GfxPreset_ULTRA
    GuiControl,, Opt2, 1
}



If (Opt8 = 1)
{
    MsgBox, you selected plugin 1
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_01
}
If (Opt8 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_01
}



If (Opt7 = 1)
{
    MsgBox, you selected plugin 2
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_02
}
If (Opt7 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_02
}





If (Opt6 = 1)
{
    MsgBox, you selected plugin 3
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_03
}
If (Opt6 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_03
}






If (Opt5 = 1)
{
    MsgBox, you selected plugin 4
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_04
}
If (Opt5 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_04
}





If (Opt4 = 1)
{
    MsgBox, you selected plugin 5
    ; Resets_forOpt2()
    ; Return
    IniWrite, TRUE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_05
}
If (Opt4 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, FALSE, %A_ScriptDir%\test.ini, PLUGINS, Plugin_05
}



Return

MyOtherLabel:
run, notepad.exe 
Return ;Should you comment this line by placing a semicolon (;) in front of it this script will 
;exit because it will encounter the exitapp command below. Get it?

GuiClose: 
ExitApp


Resets_forConflictingOpts()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt4, 0
    ; GuiControl,, Opt5, 0
    ; GuiControl,, Opt6, 0
    ; GuiControl,, Opt7, 0
    ; GuiControl,, Opt8, 0
}

Resets_forDefaultingOpts()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 1
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt4, 0
    ; GuiControl,, Opt5, 0
    ; GuiControl,, Opt6, 0
    ; GuiControl,, Opt7, 0
    ; GuiControl,, Opt8, 0
}


ResetOther1:
Resets_ForOpt1()
Return

ResetOther2:
Resets_ForOpt2()
Return

ResetOther3:
Resets_ForOpt3()
Return




Resets_forOpt1()
{
    ; GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt4, 0
    ; GuiControl,, Opt5, 0
    ; GuiControl,, Opt6, 0
    ; GuiControl,, Opt7, 0
    ; GuiControl,, Opt8, 0
}

Resets_forOpt2()
{
    GuiControl,, Opt1, 0
    ; GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt4, 0
    ; GuiControl,, Opt5, 0
    ; GuiControl,, Opt6, 0
    ; GuiControl,, Opt7, 0
    ; GuiControl,, Opt8, 0
}

Resets_forOpt3()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    ; GuiControl,, Opt3, 0
    ; GuiControl,, Opt4, 0
    ; GuiControl,, Opt5, 0
    ; GuiControl,, Opt6, 0
    ; GuiControl,, Opt7, 0
    ; GuiControl,, Opt8, 0
}






;; old logic

; Resets_forOpt1()
; {
;     ; GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt2()
; {
;     GuiControl,, Opt1, 0
;     ; GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt3()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     ; GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt4()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt5()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     ; GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt6()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     ; GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt7()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     ; GuiControl,, Opt7, 0
;     GuiControl,, Opt8, 0
; }

; Resets_forOpt8()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt4, 0
;     GuiControl,, Opt5, 0
;     GuiControl,, Opt6, 0
;     GuiControl,, Opt7, 0
;     ; GuiControl,, Opt8, 0
; }



WM_MOUSEMOVE()
{
    static CurrControl, PrevControl, _TT  ; _TT is kept blank for use by the ToolTip command below.
    CurrControl := A_GuiControl
    if (CurrControl != PrevControl and not InStr(CurrControl, " "))
    {
        ToolTip  ; Turn off any previous tooltip.
        SetTimer, DisplayToolTip, 1000
        PrevControl := CurrControl
    }
    return

    DisplayToolTip:
    SetTimer, DisplayToolTip, Off
    ToolTip % %CurrControl%_TT  ; The leading percent sign tell it to use an expression.
    SetTimer, RemoveToolTip, 3000
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}
