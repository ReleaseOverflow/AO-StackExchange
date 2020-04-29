#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; https://autohotkey.com/board/topic/3470-checkbox-example/






GLOBAL MultiSelectErrorStringGfx := "You checked too many graphics options.  The system will only accept one graphical preset input at a time, please try again."

Notepad = Somepath on your drive goes here (C:\WINDOWS) 
Gui, Add, Checkbox, x16 y17 w100 h30 vOpt01, Plugin 01
Opt01_TT := "Plugin 01 Information."
Gui, Add, Checkbox, x16 y57 w100 h30 vOpt02, Plugin 02
Opt02_TT := "Plugin 02 Information."
Gui, Add, Checkbox, x16 y97 w100 h30 vOpt03, Plugin 03
Opt03_TT := "Plugin 03 Information."
Gui, Add, Checkbox, x16 y137 w100 h30 vOpt04, Plugin 04
Opt04_TT := "Plugin 04 Information."
Gui, Add, Checkbox, x16 y177 w100 h30 vOpt05, Plugin 05
Opt05_TT := "Plugin 05 Information."
Gui, Add, Checkbox, x16 y217 w100 h30 vOpt06, Plugin 06
Opt2_TT := "Plugin 06 Information."
; Gui, Add, Checkbox, x16 y253 w100 h30 vOpt3 gResetOther3, LOW
; Opt3_TT := "The LOW Preset is the lowest graphical option preset available."
; Gui, Add, Checkbox, x16 y293 w100 h30 vOpt2 gResetOther2, MEDIUM
; Opt2_TT := "The MEDIUM Preset is the moderate graphical option preset."
; Gui, Add, Checkbox, x16 y333 w100 h30 vOpt1 gResetOther1, ULTRA
; Opt1_TT := "The ULTRA Preset is the highest graphical option preset available."

Gui, Add, Text, x136 y17 w100 h30, Test Plugin 01
Gui, Add, Text, x136 y57 w100 h30, Test Plugin 02
Gui, Add, Text, x136 y97 w100 h30, Test Plugin 03
Gui, Add, Text, x136 y137 w100 h30, Test Plugin 04
Gui, Add, Text, x136 y177 w100 h30, Test Plugin 05
Gui, Add, Text, x136 y217‬ w100 h30, Test Plugin 06


; Gui, Add, Text, x58 y230 w200 h50 vGraphicalPresets,   GRAPHICAL OPTIONS
; Gui, Add, Text, x136 y293 w100 h30, LOW Graphical Options Preset
; Gui, Add, Text, x136 y257 w100 h30, MEDIUM Graphical Options Preset
; Gui, Add, Text, x136 y333 w100 h30, ULTRA Graphical Options Preset


Gui, Add, Button, gLabel x260 y90 w100 h60 vSumbitBtn, SUBMIT
SumbitBtn_TT := "Submit Changes to stack_core.ini."
Gui, Add, Picture, gMyOtherLabel x275 y15 w50 h50, cut.ico ;Click on your image to run notepad.
Gui, Show, x159 y116 h379 w400, %ProjectName% %engine_version% %engine_terms% %ENGINEAPIs%  3.4 

; Sleep, 50
IniRead, PluginState_00, %A_ScriptDir%\stack_core.ini, PLUGINS, RunWithAdmin, KEY ERROR @ PLUGINSTATE_00
IniRead, PluginState_01, %A_ScriptDir%\stack_core.ini, PLUGINS, Do_Early_InputLock, KEY ERROR @ PLUGINSTATE_01
IniRead, PluginState_02, %A_ScriptDir%\stack_core.ini, PLUGINS, Do_Auto_AltTab, KEY ERROR @ PLUGINSTATE_02
IniRead, PluginState_03, %A_ScriptDir%\stack_core.ini, PLUGINS, Auto_LockInput, KEY ERROR @ PLUGINSTATE_03
IniRead, PluginState_04, %A_ScriptDir%\stack_core.ini, PLUGINS, Coffee_Persistent_Window_Activation, KEY ERROR @ PLUGINSTATE_04
IniRead, PluginState_05, %A_ScriptDir%\stack_core.ini, PLUGINS, Extruder_Persistent_Window_Activation, KEY ERROR @ PLUGINSTATE_05
IniRead, PluginState_06, %A_ScriptDir%\stack_core.ini, PLUGINS, Auto_Handle_InputHang, KEY ERROR @ PLUGINSTATE_06
;-----
; IniRead, GfxPreset_LOW, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW, KEY ERROR @ GRAPHICS PRESET LOW
; IniRead, GfxPreset_MEDIUM, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM, KEY ERROR @ GRAPHICS PRESET MEDIUM
; IniRead, GfxPreset_ULTRA, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA, KEY ERROR @ GRAPHICS PRESET ULTRA
; Sleep, 50

; MsgBox, %PluginState_01%
; If GfxPreset_LOW = 1
; {
;     GuiControl,, Opt3, 1
; }
; If GfxPreset_MEDIUM = 1
; {
;     GuiControl,, Opt2, 1
; }
; If GfxPreset_ULTRA = 1
; {
;     GuiControl,, Opt1, 1
; }
; If (GfxPreset_LOW = 0) and (GfxPreset_MEDIUM = 0) and (GfxPreset_ULTRA = 0)
; {
;     MsgBox, you have not selected a graphics presets, defaulting to MEDIUM GRAPHICS 
;     ; Resets_forOpt2()
;     ; Return
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
;     GuiControl,, Opt2, 1
; }


If PluginState_00 = 1
{
    GuiControl,, Opt00, 1
}
If PluginState_01 = 1
{
    GuiControl,, Opt01, 1
}
If PluginState_02 = 1
{
    GuiControl,, Opt02, 1
}
If PluginState_03 = 1
{
    GuiControl,, Opt03, 1
}
If PluginState_04 = 1
{
    GuiControl,, Opt04, 1
}
If PluginState_05 = 1
{
    GuiControl,, Opt05, 1
}
If PluginState_06 = 1
{
    GuiControl,, Opt06, 1
}
OnMessage(0x200, "WM_MOUSEMOVE")  ;;; https://www.autohotkey.com/docs/commands/Gui.htm#ExToolTip
Return 

Label: 
Gui, Submit, NoHide ;this command submits the guis' datas' state 
; If (Opt1 = 1) and (Opt2 = 1) and (Opt3 = 1)
; {
;     MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
;     Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
;     Return
; }
; If (Opt1 = 0) and (Opt2 = 0) and (Opt3 = 0)
; {
;     MsgBox, 32, ERROR, No graphics profile selected, defaulting to MEDIUM
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     Resets_forDefaultingOpts()  ;; default graphics profile to 
;     Return
; }
; If (Opt1 = 1) and (Opt2 = 1)
; {
;     MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
;     Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
;     Return
; }
; If (Opt1 = 1) and (Opt3 = 1)
; {
;     MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
;     Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
;     Return
; }
; If (Opt2 = 1) and (Opt3 = 1)
; {
;     MsgBox, 32, ERROR, %MultiSelectErrorStringGfx%
;     Resets_forConflictingOpts()  ;; if more than one option from opt1-opt3 is checked, reset them all after throwing an error on submit
;     Return
; }









; If (Opt1 = 1)
; {
;     MsgBox, you selected ULTRA GRAPHICS 
;     ; Resets_forOpt2()
;     ; Return
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
; }
; If (Opt1 = 0)
; {
;     ; MsgBox, you selected ULTRA GRAPHICS 
;     ; ; Resets_forOpt2()
;     ; ; Return
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
; }



; If (Opt2 = 1)
; {
;     MsgBox, you selected MEDIUM GRAPHICS 
;     ; Resets_forOpt2()
;     ; Return
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
; }
; If (Opt2 = 0)
; {
;     ; MsgBox, you selected ULTRA GRAPHICS 
;     ; ; Resets_forOpt2()
;     ; ; Return
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
; }




; If (Opt3 = 1)
; {
;     MsgBox, you selected LOW GRAPHICS 
;     ; Resets_forOpt2()
;     ; Return
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
; }
; If (Opt3 = 0)
; {
;     ; MsgBox, you selected ULTRA GRAPHICS 
;     ; ; Resets_forOpt2()
;     ; ; Return
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
; }


; If (Opt1 = 0) and (Opt2 = 0) and (Opt3 = 0)
; {
;     MsgBox, you have not selected a graphics presets, defaulting to MEDIUM GRAPHICS 
;     ; Resets_forOpt2()
;     ; Return
;     IniWrite, 1, %A_ScriptDir%\stack_core.ini, API, GfxPreset_MEDIUM
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_LOW
;     IniWrite, 0, %A_ScriptDir%\stack_core.ini, API, GfxPreset_ULTRA
;     GuiControl,, Opt2, 1
; }



If (Opt00 = 1)
{
    MsgBox, you selected plugin 1
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, RunWithAdmin
}
If (Opt00 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, RunWithAdmin
}






If (Opt01 = 1)
{
    MsgBox, you selected plugin 1
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, Do_Early_InputLock
}
If (Opt01 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, Do_Early_InputLock
}



If (Opt02 = 1)
{
    MsgBox, you selected plugin 2
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, Do_Auto_AltTab
}
If (Opt02 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, Do_Auto_AltTab
}





If (Opt03 = 1)
{
    MsgBox, you selected plugin 3
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, Auto_LockInput
}
If (Opt03 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, Auto_LockInput
}






If (Opt04 = 1)
{
    MsgBox, you selected plugin 4
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, Coffee_Persistent_Window_Activation
}
If (Opt04 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, Coffee_Persistent_Window_Activation
}





If (Opt05 = 1)
{
    MsgBox, you selected plugin 5
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, Extruder_Persistent_Window_Activation
}
If (Opt05 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, Extruder_Persistent_Window_Activation
}






If (Opt06 = 1)
{
    MsgBox, you selected plugin 6
    ; Resets_forOpt2()
    ; Return
    IniWrite, 1, %A_ScriptDir%\stack_core.ini, PLUGINS, Auto_Handle_InputHang
}
If (Opt06 = 0)
{
    ; MsgBox, you selected ULTRA GRAPHICS 
    ; ; Resets_forOpt2()
    ; ; Return
    IniWrite, 0, %A_ScriptDir%\stack_core.ini, PLUGINS, Auto_Handle_InputHang
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
    ; GuiControl,, Opt05, 0
    ; GuiControl,, Opt04, 0
    ; GuiControl,, Opt03, 0
    ; GuiControl,, Opt02, 0
    ; GuiControl,, Opt01, 0
}

Resets_forDefaultingOpts()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 1
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt05, 0
    ; GuiControl,, Opt04, 0
    ; GuiControl,, Opt03, 0
    ; GuiControl,, Opt02, 0
    ; GuiControl,, Opt01, 0
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
    ; GuiControl,, Opt05, 0
    ; GuiControl,, Opt04, 0
    ; GuiControl,, Opt03, 0
    ; GuiControl,, Opt02, 0
    ; GuiControl,, Opt01, 0
}

Resets_forOpt2()
{
    GuiControl,, Opt1, 0
    ; GuiControl,, Opt2, 0
    GuiControl,, Opt3, 0
    ; GuiControl,, Opt05, 0
    ; GuiControl,, Opt04, 0
    ; GuiControl,, Opt03, 0
    ; GuiControl,, Opt02, 0
    ; GuiControl,, Opt01, 0
}

Resets_forOpt3()
{
    GuiControl,, Opt1, 0
    GuiControl,, Opt2, 0
    ; GuiControl,, Opt3, 0
    ; GuiControl,, Opt05, 0
    ; GuiControl,, Opt04, 0
    ; GuiControl,, Opt03, 0
    ; GuiControl,, Opt02, 0
    ; GuiControl,, Opt01, 0
}






;; old logic

; Resets_forOpt1()
; {
;     ; GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt2()
; {
;     GuiControl,, Opt1, 0
;     ; GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt3()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     ; GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt05()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     ; GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt04()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     ; GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt03()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     ; GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt02()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     ; GuiControl,, Opt02, 0
;     GuiControl,, Opt01, 0
; }

; Resets_forOpt01()
; {
;     GuiControl,, Opt1, 0
;     GuiControl,, Opt2, 0
;     GuiControl,, Opt3, 0
;     GuiControl,, Opt05, 0
;     GuiControl,, Opt04, 0
;     GuiControl,, Opt03, 0
;     GuiControl,, Opt02, 0
;     ; GuiControl,, Opt01, 0
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
